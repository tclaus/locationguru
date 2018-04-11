class AddCountryIndexToLocations < ActiveRecord::Migration[5.1]
  def change
    add_index :locations, :country
  end
end
