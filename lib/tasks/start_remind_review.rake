namespace :locationguru do
  desc 'Start Send review reminder mail'
  task start_send_review_reminder_mail_job: :environment do
    SendReviewReminderJob.perform_now
  end
end
