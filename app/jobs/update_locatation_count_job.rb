# Updates the current count for user and locations in this week
class UpdateLocatationCountJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Do something later
    update_total_location_count
  end

  private

  def update_total_location_count
    logger.info 'Updating total locations in current week'
    Counter.update_total_location_count

    logger.info 'Updating total active locations in current week'
    Counter.update_active_location_count

    logger.info 'Updating total confirmed users in current week'
    Counter.update_total_active_user_count
  end
end
