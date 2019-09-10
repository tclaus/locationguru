# frozen_string_literal: true

require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.cron '5 10 * * *' do
  # do something every day, five minutes after 10am
  # (see "man 5 crontab" in your terminal)
  SendActivationReminderMailsJob.perform_now
end

scheduler.cron '5 0 * * *' do
  # do something every day, five minutes after midnight
  # (see "man 5 crontab" in your terminal)
  DeleteNotActivatedAccountsJob.perform_now
end
