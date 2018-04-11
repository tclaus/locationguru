class AddCountryToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :country, :string
  end
end
