class AddReservationTokenToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :review_token, :string
    add_index :reservations, :review_token
  end
end
