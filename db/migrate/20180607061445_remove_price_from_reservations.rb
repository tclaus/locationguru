class RemovePriceFromReservations < ActiveRecord::Migration[5.2]
  def change
    remove_column :reservations, :price, :integer
    remove_column :reservations, :total, :integer
    remove_column :reservations, :end_date, :datetime
  end
end
