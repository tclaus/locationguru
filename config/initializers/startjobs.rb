# frozen_string_literal: true

require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.cron '5 10 * * *' do
  # Send a reminder on not activated venus every day, five minutes after 10am
  # (see "man 5 crontab" in your terminal)
  SendActivationReminderMailsJob.perform_now
end

scheduler.cron '5 11 * * *' do
  # Send a reminder on too less fotos every day, five minutes after 11am
  # (see "man 5 crontab" in your terminal)
  SendNotificationOnPhotosJob.perform_now
  SendReviewReminderJob.perform_now
end

scheduler.cron '5 0 * * *' do
  # Homecleaning Tasks every day, five minutes after midnight
  # (see "man 5 crontab" in your terminal)
  DeleteNotActivatedAccountsJob.perform_now
  UpdateLocatationCountJob.perform_now
end
