class AddSourceFieldsToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :email, :string
    add_column :reservations, :from_type, :string
    add_column :reservations, :status, :string
  end
end
