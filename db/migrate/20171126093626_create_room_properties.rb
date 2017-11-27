class CreateRoomProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :room_properties do |t|
      t.references :room
      t.string :key

      t.timestamps
    end
  end
end
