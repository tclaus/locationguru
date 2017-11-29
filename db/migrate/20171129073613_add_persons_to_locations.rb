class AddPersonsToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :max_persons, :decimal, precision: 5, scale: 0
  end
end
