# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :location

  def display_text
    logger.debug "reservation - text: #{I18n.t(status, scope: 'reservations')}"
    "#{I18n.t(status, scope: 'reservations')[0]}: #{location.listing_name}"
  end

  def set_status_booked
    self.status = 'booked'
    save
  end

  def set_status_inquery
    self.status = 'inquery'
    save
  end
end
