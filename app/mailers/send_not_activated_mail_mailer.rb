# frozen_string_literal: true

class SendNotActivatedMailMailer < ApplicationMailer
  default from: 'Thorsten Claus <thorsten.claus@locationguru.net>'

  def first_activation_reminder
    @location = params[:location]
    @edit_url = listing_location_url(@location)
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end

  def second_activation_reminder
    @location = params[:location]
    @edit_url = listing_location_url(@location)
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end

  def last_activation_reminder
    @location = params[:location]
    @edit_url = listing_location_url(@location)
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end
end
