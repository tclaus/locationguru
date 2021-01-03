# frozen_string_literal: true

## Remove any messages that are expired
class DeleteExpiredMessagesJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    delete_expired_messages
  end

  private

  def delete_expired_messages
    # Messages should not be stored forever
    # Some private information might occure in messge text ("my dougthers 18'th birthday")

    time_ago = Date.today - 12.month
    invalid_messges = Message.where('created_at < ?', time_ago)
    logger.info("Delete #{invalid_messges.count} reached expire time")
    invalid_messges.delete_all
  end
end
