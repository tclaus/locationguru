class AddMessageToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :message, :text
  end
end
