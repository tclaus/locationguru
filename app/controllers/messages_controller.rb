# frozen_string_literal: true

include ApplicationHelper

class MessagesController < ApplicationController
  before_action :set_location, except: %i[index new create]
  before_action :authenticate_user!, except: [:create]
  before_action :is_authorized, only: %i[show]

  def create
    # create a message and if a date was given, create a reservation
    @location = Location.find(params[:location_id])

    unless permitMessages[:inquery_date].blank?
      # create reservations
      logger.info 'Create a new reservation'

      @reservation = Reservation.new
      @reservation.user = @location.user # For location
      @reservation.location = @location
      @reservation.email = permitMessages[:email]
      @reservation.from_type = 'customer' # who has created this data? customer / owner
      @reservation.message = permitMessages[:message]
      @reservation.status = 'inquery' # current status of reservation: inquery (anfrage), booked
      @reservation.start_date = permitMessages[:inquery_date]
      logger.info " Reservation startdate = #{@reservation.start_date}"
      if !@reservation.save
        logger.warn " Failure saving a new reservation: #{@reservation.errors.messages}"
      else
        logger.info ' New reservation created'
      end
    end

    @message = Message.new(permitMessages)
    @message.location_id = @location.id
    @message.user_id = @location.user_id

    if @message.save

      # Increate mail send counter
      Counter.increase_mail(@message.id)

      # Send a mail to receiver
      LocationMailer
        .with(message: @message, location: @location)
        .location_mail.deliver_later
      # Send mail for reference to sender
      LocationMailer
        .with(message: @message, location: @location)
        .location_mail_to_sender.deliver_later

      flash[:notice] = t('.message_send')
      redirect_to location_path(@location)
    else
      logger.warn "Failure saving message: #{@message.errors.messages}"
      flash[:notice] = t('.message_send_error')
      render send_message_path(@message)
    end
  end

  # create a dummy user to enable semi - anonymous inqueries
  def dummy_user(mail)
    # Find a user by index_users_on_email!
    user = User.find_by(email: mail)
    if user.blank?
      user = User.new
      user.email = "SYSTEM.#{mail}"
      user.role = 'SYSTEM' # Mark as temporary added user
      user.first_name = 'Temporary System user'
      user.password = 'No Password here!' # TODO: generate a randon hash!
      if user.save
        logger.info "* Created new temporary user with: #{user.attributes.inspect}"
      else
        logger.error "Failed creating a new user with error: #{user.errors.messages}"
      end
    else
      logger.info "Found existing user with given mail address: #{mail}"
    end
    user
  end

  def show
    @message = Message
               .includes(:location)
               .find(params[:id])

    unless @message.isRead
      @message.isRead = true
      message = Message.find(@message.id)
      message.isRead = true
      message.save
    end
    @message
  end

  def destroy
    @message = Message.find(params[:id])
    @message.delete
    respond_to :js
  end

  private

  def set_location
    @location = Location.find(params[:location_id])
  end

  def is_authorized
    redirect_to root_path, alert: t('not_authorized') unless (current_user.id == @location.user_id) || current_user.isAdmin
  end

  def permitMessages
    params.require(:message).permit(:user_id,
                                    :location_id,
                                    :email,
                                    :name,
                                    :message,
                                    :inquery_date,
                                    :accept)
  end
end
