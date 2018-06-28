class AddCounterTypeToCounter < ActiveRecord::Migration[5.2]
  def change
    add_column :counters, :context_type, :string
    add_index :counters, :context_type  
  end
end
