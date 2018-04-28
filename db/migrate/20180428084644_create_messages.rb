class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.bigint :user_id
      t.bigint :location_id
      t.string :email
      t.string :name
      t.text :message
      t.index ["user_id"], name: "index_message_on_user_id"
      t.index ["location_id"], name: "index_locations_on_location_id"
      t.timestamps
    end
  end
end
