class AddCountryToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :country, :string
    add_index :locations, :index
  end
end
