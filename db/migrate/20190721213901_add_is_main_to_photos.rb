class AddIsMainToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :is_main, :boolean, :default false
  end
end
