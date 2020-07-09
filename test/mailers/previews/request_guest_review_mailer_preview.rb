# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/request_guest_review_mailer
class RequestGuestReviewMailerPreview < ActionMailer::Preview
  def request_review_mail
    demo_reservation = Reservation.first
    RequestGuestReviewMailer
      .with(reservation: demo_reservation)
      .request_review
  end
end
