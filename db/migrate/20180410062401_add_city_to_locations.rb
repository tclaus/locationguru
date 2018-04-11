class AddCityToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :city, :string
  end
end
