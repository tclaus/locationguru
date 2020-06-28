namespace :locationguru do
  desc 'Migrate not activated notification to SentNotification table'
  task migrate_sent__not_activated_notifications: :environment do
    # Get all notifications with one send message
    # Create Sent_notification entry
    locations = Location.where(MailSentNotActivated3: true)
    locations.all.each do |location|
      SentNotification.create_sent_notification(location.id, 'not activated 3')
      puts("Updated #{location.id} '#{location.listing_name}' to 'not activated 3'")
    end

    locations = Location.where(MailSentNotActivated2: true)
    locations.all.each do |location|
      SentNotification.create_sent_notification(location.id, 'not activated 2')
      puts("Updated #{location.id} '#{location.listing_name}' to 'not activated 2'")
    end

    locations = Location.where(MailSentNotActivated3: true)
    locations.all.each do |location|
      SentNotification.create_sent_notification(location.id, 'not activated 1')
      puts("Updated #{location.id} '#{location.listing_name}' to 'not activated 1'")
    end

  end
end
