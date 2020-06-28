# frozen_string_literal: true

require 'test_helper'

class SentNotificationTest < ActiveSupport::TestCase
  test 'create and find notification markers' do
    location = Location.first
    has_marker = SentNotification.sent_notification?(location.id, 'a marker')
    assert_not(has_marker)

    SentNotification.create_sent_notification(location.id, 'a marker')
    has_marker = SentNotification.sent_notification?(location.id, 'a marker')
    assert(has_marker)
  end
end
