class AddlanguageIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :language_id, :string, default: 'de'
  end
end
