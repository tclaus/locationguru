class AddEmailToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :email, :string
    add_index :locations, :email
  end
end
