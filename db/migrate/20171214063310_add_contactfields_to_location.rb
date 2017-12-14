class AddContactfieldsToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :phonenumber, :string
    add_column :locations, :website, :string
  end
end
