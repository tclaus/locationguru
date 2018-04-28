class AddIsProToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :isPro, :boolean
  end
end
