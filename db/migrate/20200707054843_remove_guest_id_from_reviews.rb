class RemoveGuestIdFromReviews < ActiveRecord::Migration[5.2]
  def change
    # Not neeed, reviews point to location and reservation
    remove_column :reviews, :type
    remove_column :reviews, :guest_id
  end
end
