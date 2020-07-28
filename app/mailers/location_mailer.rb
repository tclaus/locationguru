# frozen_string_literal: true

class LocationMailer < ApplicationMailer
  before_action { @location = params[:location] }

  # Send to location owner
  def location_mail
    @message = params[:message]
    @mail_to_owner = true
    email_with_name = @location.user.email

    headers['Venue-Message-Type'] = 'inquery'
    headers['Venue-Message-Id'] = @message.id

    mail(to: email_with_name,
         from: "'#{@message.name} via Locationguru'<#{@message.email}>",
         reply_to: @message.email,
         subject: t('.subject', location_name: @location.listing_name))
  end

  # Send reference Mail to requester
  def location_mail_to_sender
    @message = params[:message]

    email_with_name = "#{@message.name}<#{@message.email}>"

    headers['Venue-Message-Type'] = 'inquery-reference'
    headers['Venue-Message-Id'] = @message.id
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end

  def location_activated
    email_with_name = @location.user.email
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end

  def location_deactivated
    email_with_name = @location.user.email
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end
end
