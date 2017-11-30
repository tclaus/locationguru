class AddAmmeitiesToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :has_heating, :boolean
    add_column :locations, :has_kitchen, :boolean
    add_column :locations, :has_outdoor, :boolean
    add_column :locations, :has_parking_space, :boolean
    add_column :locations, :has_furniture, :boolean
    add_column :locations, :catering, :string
    add_column :locations, :has_air_conditioning, :boolean
    add_column :locations, :has_music_eq, :boolean
  end
end
