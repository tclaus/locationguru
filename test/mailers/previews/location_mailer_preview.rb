# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/location_mailer

class LocationMailerPreview < ActionMailer::Preview
  def location_requester
    LocationMailer.with(location: Location.first,
                        message: Message.first)
                  .location_mail_to_sender
  end

  def location_mail_request
    LocationMailer.with(location: Location.first,
                        message: Message.first)
                  .location_mail
  end

  def location_activated
    LocationMailer.with(location: Location.first)
                  .location_activated
  end

  def location_deactivated
    LocationMailer.with(location: Location.first)
                  .location_deactivated
  end
end
