class AddAcceptToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :accept, :boolean
  end
end
