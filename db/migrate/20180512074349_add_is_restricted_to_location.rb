class AddIsRestrictedToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :isRestricted, :boolean, default: false, null: false
  end
end
