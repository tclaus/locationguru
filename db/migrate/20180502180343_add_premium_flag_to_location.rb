class AddPremiumFlagToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :isPremium, :boolean, null: false, default: false
  end
end
