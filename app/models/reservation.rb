class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :location

  def display_text
    logger.debug "reservation - text: #{I18n.t(self.status, scope:'reservations')}"
    "#{I18n.t(self.status, scope:'reservations')[0]}: #{self.location.listing_name}"
  end

  def set_status_booked
    self.status = "booked"
    self.save
  end

  def set_status_inquery
    self.status = "inquery"
    self.save
  end

end
