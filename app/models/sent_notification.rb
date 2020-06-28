# frozen_string_literal: true

# Stores a list of notifications
class SentNotification < ApplicationRecord

  belongs_to :user, foreign_key: 'target_user_id', optional: true
  belongs_to :location, foreign_key: 'target_location_id', optional: true

  # returns true if for this location a notification was already created
  def self.sent_notification?(location_id, reason)
    find_by(target_location_id: location_id, reason: reason) != nil
  end

  def self.create_sent_notification(location_id, reason)
    if find_by(target_location_id: location_id, reason: reason).nil?
      create(target_location_id: location_id, reason: reason)
    end
  end
end
