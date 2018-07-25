require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.cron '1 * * * *' do
  SendActivationReminderMailsJob.perform_now
end
