class AddIsReadToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :isRead, :boolean, null: false, default: false
  end
end
