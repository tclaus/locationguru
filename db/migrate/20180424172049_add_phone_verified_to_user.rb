class AddPhoneVerifiedToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone_verified, :boolean, null: false, default: false
    add_column :users, :pin, :string
  end
end
