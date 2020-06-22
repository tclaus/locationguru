class CreateSentNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :sent_notifications do |t|
      t.integer :target_user_id
      t.integer :target_location_id
      t.string :reason

      t.timestamps
    end
    add_index :sent_notifications, :reason
  end
end
