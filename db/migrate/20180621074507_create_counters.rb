class CreateCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :counters do |t|
      t.string :context
      t.string :type
      t.integer :year
      t.integer :month
      t.integer :day
      t.integer :count

      t.timestamps
    end
    add_index :counters, :context
    add_index :counters, :type
    add_index :counters, :year
    add_index :counters, :month
    add_index :counters, :day
  end
end
