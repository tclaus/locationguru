class CreateAvailableProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :available_properties do |t|
      t.string :key

      t.timestamps
    end
  end
end
