include ApplicationHelper

class MessagesController < ApplicationController
  before_action :set_location, except: %i[index new create]
  before_action :authenticate_user!, except: [:create]
  before_action :is_authorized, only: %i[show]

  def create
    @location = Location.find(params[:location_id])

    @message = Message.new(permitMessages)
    @message.location_id = @location.id
    @message.user_id = @location.user_id

    if @message.save
      # Send a mail to receiver
      LocationMailer.with(message: @message, location: @location).location_mail.deliver_later
      # Send mail for reference to sender
      LocationMailer.with(message: @message, location: @location).location_mail_to_sender.deliver_later

      flash[:notice] = t('.message_send')
      redirect_to location_path(@location)
    else
      logger.warn "Failure saving message: #{@message.errors.messages.to_s}"
      flash[:notice] = t('.message_send')
      render send_message_path(@message)
    end
  end

  def show;
    #  @message = Message.find(params[:id])

    @message = Message
    .select('messages.id as id, messages.email as email, messages.name as name, messages.message as message, messages."isRead" as is_read, locations.id as location_id, locations.listing_name as listing_name, messages.created_at as created_at')
    .joins(:location)
    .find(params[:id])

  end

  private

  def set_location

    @location = Location.find(params[:location_id])
    logger.debug "set location: #{@location}"
  end

  def is_authorized
    logger.debug "is authorized"
     redirect_to root_path, alert: t('not_authorized') unless (current_user.id == @location.user_id) || current_user.isAdmin
  end

  def permitMessages
    params.require(:message).permit(:user_id,
                                    :location_id,
                                    :email,
                                    :name,
                                    :message,
                                    :accept)
  end
end
