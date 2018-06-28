class RemoveTypeFromCounter < ActiveRecord::Migration[5.2]
  def change
    remove_column :counters, :type, :string
  end
end
