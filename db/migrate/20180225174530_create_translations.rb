class CreateTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :translations do |t|
      t.integer :text_id
      t.string :language_id
      t.string :category
      t.string :translation
    end
    add_index :translations, [:text_id, :language_id, :category]
  end
end
