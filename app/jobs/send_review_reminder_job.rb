# frozen_string_literal: true

# Send a reminder some days after the event to the requester to review the
# venue
class SendReviewReminderJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    send_review_reminder
  end

  private

  def send_review_reminder
    # Find reservations without an review
    # And with a start_date which is in the past
    reservations_without_review = Reservation.not_invited_for_review
    if reservations_without_review.empty?
      logger.info 'No review invitations to send'
    end
    # What if, ssomeone sends masses of requests, just to can sent a review?

    # Last diff(start_date ) > 5 Tage
    # Last user should have a request review every 5 days
    # store user + location; last date
    already_send = {}
    reservations_without_review.each do |reservation|
      # dont send multiple mails to same user
      unless already_send.key?("#{reservation.email}+#{reservation.location_id}")
        send_request_review_mail(reservation) unless reservation.nil?
        logger.info "Send a review request for reservation #{reservation.id}"
        already_send["#{reservation.email}+#{reservation.location_id}"] = reservation.start_date
      end
      reservation.set_invitation_sent
    end
  end

  def send_request_review_mail(reservation)
    localize(reservation.location)
    RequestGuestReviewMailer
      .with(reservation: reservation)
      .request_review
      .deliver_now
  end
end
