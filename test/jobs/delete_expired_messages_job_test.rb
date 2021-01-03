class DeleteExpiredMessagesJobTest < ActiveJob::TestCase
  test 'that expired messages will be deleted' do
    # Create unconfirmed mail
    now = Date.today
    time_ago = (now - 13.months)
    message = Message.create(email: 'spam@example.com', 
      location_id: 1, 
      user_id: 1, 
      name: "Very old inquery",
      message: "This is a message that is already expired.")
    message.created_at = time_ago
    assert message.save!
    DeleteExpiredMessagesJob.perform_now
    assert(Message.where(["created_at <= ?", Date.today - 12.month]).count, 0)
  end
end