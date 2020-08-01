# frozen_string_literal: true

# This provider contains reminders to the submitter to activate their
# venues
class NotActivatedMailMailer < ApplicationMailer
  default from: 'Locationguru.net <support@locationguru.net>'

  def first_activation_reminder
    @location = params[:location]
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end

  def second_activation_reminder
    @location = params[:location]
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end

  def last_activation_reminder
    @location = params[:location]
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end
end
