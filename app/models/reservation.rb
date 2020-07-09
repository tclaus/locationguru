# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_one :review

  before_create :generate_unique_secure_token

  REASON = 'review_reminder'

  def display_text
    logger.debug "reservation - text: #{I18n.t(status, scope: 'reservations')}"
    "#{I18n.t(status, scope: 'reservations')[0]}: #{location.listing_name}"
  end

  # Returns all reservations that have no invitation for review sent
  # to the host or requester for some days
  def self.not_invited_for_review
    sql = 'select * from reservations ' \
          'where reservations.id not in ' \
          "(select target_location_id from sent_notifications where reason = ?)" \
          'and reservations.start_date < ?'

    start_date = Date.today - 5.days
    find_by_sql([sql, REASON, start_date])
  end

  def set_invitation_sent
    SentNotification.create_sent_notification(id, REASON)
  end

  def set_status_booked
    self.status = 'booked'
    save
  end

  def set_status_inquery
    self.status = 'inquery'
    save
  end

  def generate_unique_secure_token
    self.review_token = SecureRandom.base58(24)
  end
end
