class AddInqueryDateToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :inquery_date, :date
  end
end
