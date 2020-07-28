class RemoveMailSentNotActivatedFromLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :MailSentNotActivated1, :boolean
    remove_column :locations, :MailSentNotActivated2, :boolean
    remove_column :locations, :MailSentNotActivated3, :boolean
  end
end
