class AddSubTitleToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :subtitle, :string, limit: 200
  end
end
