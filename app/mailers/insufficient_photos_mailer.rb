# frozen_string_literal: true

class InsufficientPhotosMailer < ApplicationMailer
  def send_mail
    @location = params[:location]
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end
end
