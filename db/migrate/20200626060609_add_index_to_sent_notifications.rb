class AddIndexToSentNotifications < ActiveRecord::Migration[5.2]
  def change
    add_index :sent_notifications, :target_location_id
    add_index :sent_notifications, :target_user_id
  end
end
