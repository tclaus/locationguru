class SendActivationReminderMailsJob < ApplicationJob
  queue_as :default

 # Send out a mail to every location not activated for a decent peroid of time
  def perform(*args)
    logger.debug 'Start reminder activation job'

    now = Date.today
    time_ago = (now - 30)
    perform_query_level3(time_ago)

    now = Date.today
    time_ago = (now - 7)
    perform_query_level2(time_ago)

    now = Date.today
    time_ago = (now - 1)
    perform_query_level1(time_ago)

  end

private

  def perform_query_level3(date)
    logger.debug "Start quering locations not activated older than #{date}"
    locations_Level1 = Location.where('active = false AND "MailSentNotActivated3" = false AND created_at < ?', date )
    locations_Level1.all.each do |location|
      if !location.user.blank?
        send_not_activated_mail_level3(location)
        location.MailSentNotActivated1 = true
        location.MailSentNotActivated2 = true
        location.MailSentNotActivated3 = true
        location.save
      end
    end
  end

  def perform_query_level2(date)
    logger.debug "Start quering locations not activated older than #{date}"
    locations_Level1 = Location.where('active = false AND "MailSentNotActivated2" = false AND created_at < ?', date )
    locations_Level1.all.each do |location|
      if !location.user.blank?
        send_not_activated_mail_level2(location)
        location.MailSentNotActivated1 = true
        location.MailSentNotActivated2 = true
        location.save
      end
    end
  end

  def perform_query_level1(date)
    logger.debug "Start quering locations not activated older than #{date}"
    locations_Level1 = Location.where('active = false AND "MailSentNotActivated1" = false AND created_at < ?', date )
    locations_Level1.all.each do |location|
      if !location.user.blank?
        send_not_activated_mail_level1(location)
        location.MailSentNotActivated1 = true
        location.save
      end
    end
  end


  def send_not_activated_mail_level1(location)
    logger.info " * Send not activated mail1 to Location_id: #{location.id} with name #{location.listing_name}"
    set_language(location)
    SendNotActivatedMailMailer.with(location: location).first_activation_reminder.deliver_now
  end

  def send_not_activated_mail_level2(location)
    logger.info " * Send not activated mail2 to Location_id: #{location.id} with name #{location.listing_name}"
    set_language(location)
    SendNotActivatedMailMailer.with(location: location).second_activation_reminder.deliver_now
  end

  def send_not_activated_mail_level3(location)
    logger.info " * Send not activated mail3 to Location_id: #{location.id} with name #{location.listing_name}"
    set_language(location)
    SendNotActivatedMailMailer.with(location: location).last_activation_reminder.deliver_now
  end

  def set_language(location)
    if !location.user.blank?
      I18n.locale = location.user.language_id
    else
      I18n.locale = "de"
    end
  end

end
