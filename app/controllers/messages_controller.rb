class MessagesController < ApplicationController
  before_action :authenticate_user!, except: [:create]

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
    end
  end

  def show; end

  private

  def permitMessages
    params.require(:message).permit(:user_id,
                                    :location_id,
                                    :email,
                                    :name,
                                    :message,
                                    :accept)
  end
end
