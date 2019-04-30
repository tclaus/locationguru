class RemoveColumnFromMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :for_date, :string
  end
end
