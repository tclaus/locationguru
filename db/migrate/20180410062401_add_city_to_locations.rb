class AddCityToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :city, :string
    add_index :locations, :city
  end
end
