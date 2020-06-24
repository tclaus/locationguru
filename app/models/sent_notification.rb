# frozen_string_literal: true

# Stores a list of notifications
class SentNotification < ApplicationRecord
  # returns true if for this location a notification was already created
  def self.sent_notification?(location_id, reason)
    find_by(target_location_id: location_id, reason: reason) != nil
  end

  def self.create_sent_notification(location_id, reason)
    create(target_location_id: location_id, reason: reason)
  end
end
