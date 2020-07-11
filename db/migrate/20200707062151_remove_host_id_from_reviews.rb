class RemoveHostIdFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :host_id
  end
end
