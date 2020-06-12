class AddWeekToCounters < ActiveRecord::Migration[5.2]
  def change
    add_column :counters, :week, :integer
  end
end
