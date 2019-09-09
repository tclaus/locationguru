# frozen_string_literal: true

require 'test_helper'

class TestSendActionvation < ActiveJob::TestCase
  test 'activation mail will send' do
      SendActivationReminderMailsJob.perform_now
  end
end
