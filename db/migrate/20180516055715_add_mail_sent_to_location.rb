class AddMailSentToLocation < ActiveRecord::Migration[5.2]
  def change
    # Notify about already sent mails
    add_column :locations, :MailSentNotActivated1, :boolean, default: false, null: false
    add_column :locations, :MailSentNotActivated2, :boolean, default: false, null: false
    add_column :locations, :MailSentNotActivated3, :boolean, default: false, null: false
  end
end
