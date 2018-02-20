class AddIsExclusiveAvailableToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :isExclusiveAvailable, :boolean
  end
end
