class AddNameForReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :name, :string
  end
end
