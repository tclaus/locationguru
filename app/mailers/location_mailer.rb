# frozen_string_literal: true

class LocationMailer < ApplicationMailer
  before_action { @location = params[:location] }

  # Send to location owner
  def location_mail
    @message = params[:message]
    @mail_to_owner = true
    email_with_name = "LocationGuru.net <#{@location.user.email}>"

    headers['Venue-Message-Type'] = 'inquery'
    headers['Venue-Message-Id'] = @message.id

    mail(to: email_with_name,
         from: "#{@message.name} (Location Guru) <no-reply@locationguru.net>",
         reply_to: @message.email,
         subject: t('.subject', location_name: @location.listing_name))
  end

  # reference Mail to requester
  def location_mail_to_sender
    @message = params[:message]

    email_with_name = "#{@message.name} (Location Guru) <#{@message.email}>"

    headers['Venue-Message-Type'] = 'inquery-reference'
    headers['Venue-Message-Id'] = @message.id
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end

  def location_activated
    @edit_url = listing_location_url(@location)
    @show_url = location_url(@location)
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    mail(to: email_with_name,
         from: 'Location Guru <no-reply@locationguru.net>',
         subject: t('.subject', location_name: @location.listing_name))
  end

  def location_deactivated
    @edit_url = listing_location_url(@location)
    @show_url = location_url(@location)
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    mail(to: email_with_name,
         from: 'Location Guru <no-reply@locationguru.net>',
         subject: t('.subject', location_name: @location.listing_name))
  end
end
