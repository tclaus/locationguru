class DeleteNotActivatedAccountsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Do something later
    delete_not_activated_mails
  end

  private
  def delete_not_activated_mails
    # Get all user account that
    # Are not activated
    # for the last 21 days
    now = Date.today
    time_ago = (now - 3)

    invalid_users= User.where('sign_in_count = 0 and created_at < ?', time_ago)
    logger.info("Delete #{invalid_users.count} invalid user accounts")
    invalid_users.delete_all
  end
end
