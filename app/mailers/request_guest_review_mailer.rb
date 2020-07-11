# frozen_string_literal: true

class RequestGuestReviewMailer < ApplicationMailer
  def request_review
    @reservation = params[:reservation]
    @location = @reservation.location

    @edit_url = listing_location_url(@location)
    email_with_name = "LocationGuru.net <#{@reservation.email}>"
    logger.info("Send mail to #{email_with_name}")
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name))
  end
end
