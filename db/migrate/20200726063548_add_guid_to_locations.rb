class AddGuidToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :guid, :string
    add_index :locations, :guid
  end
end
