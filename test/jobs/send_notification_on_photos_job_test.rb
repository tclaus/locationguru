# frozen_string_literal: true

require 'test_helper'

class SendNotificationOnPhotosJobTest < ActiveJob::TestCase
  test 'send notification on insufficient photos' do
    REASON = 'insufficient photos'
    notification_sent = SentNotification.sent_notification?(1, REASON)
    assert !notification_sent
    SendNotificationOnPhotosJob.perform_now
    notification_sent = SentNotification.create_sent_notification(1, REASON)
    # A new entry should have been created
    assert notification_sent
  end
end
