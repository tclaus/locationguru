class AddTextfieldToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :suitableForText, :string
  end
end
