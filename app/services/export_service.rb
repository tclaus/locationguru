# frozen_string_literal: true

## Exports lits of usert
class ExportService
  # Creates a fileobject with all confirmed users
  def file_user_list
    users = User.where('confirmed_at IS NOT NULL').order(:id)
    file = Tempfile.new('exported_userlist')
    users.each do |user|
      file << user.email << ','
      file << user.first_name << ','
      file << user.last_name << ','
      file << user.language_id << ','
      file << 'Location_Provider' << "\n"
    end
    file.flush
    file
  end

  # Creates a fileobject with all inbound e-mail adresses from messages
  def file_message_list
    messages = Message.all.order(:id)
    file = Tempfile.new('exported_messageslist')
    messages.each do |message|
      file << message.email << ','
      file << message.name << ','
      file << 'Message_Senders' << "\n"
    end
    file.flush
  end
end
