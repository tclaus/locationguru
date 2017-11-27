class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :building_type
      t.string :room_type
      t.string :listing_name
      t.text :summary
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
