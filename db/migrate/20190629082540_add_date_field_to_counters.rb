class AddDateFieldToCounters < ActiveRecord::Migration[5.2]
  def change
    add_column :counters, :date_of_count, :date
  end
end
