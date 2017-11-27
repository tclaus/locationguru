class CreatePropertiesTexts < ActiveRecord::Migration[5.1]
  def change
    create_table :properties_texts do |t|
      t.string :key
      t.string :language_key
      t.text :text

      t.timestamps
    end
  end
end
