# frozen_string_literal: true

# Checks for created but not activated venues
class SendActivationReminderMailsJob < ApplicationJob
  queue_as :default

  NOT_ACTIVATED_1 = 'not activated 1'
  NOT_ACTIVATED_2 = 'not activated 2'
  NOT_ACTIVATED_3 = 'not activated 3'

  # Send out a mail to every location not activated for a decent peroid of time
  def perform(*_args)
    logger.debug 'Start reminder activation job'

    perform_query_level3(Date.today - 30.days)
    perform_query_level2(Date.today - 7.days)
    perform_query_level1(Date.today - 1.days)
  end

  private

  def perform_query_level3(date)
    logger.debug "Start quering locations not activated older than #{date}"
    locations = SentNotificationService.location_not_handled_by(NOT_ACTIVATED_3, false)
    locations.each do |location|
      next if location.user.blank?
      next if location.created_at >= date

      localize(location)
      send_not_activated_mail_level3(location)
      SentNotification.create_sent_notification(location.id, NOT_ACTIVATED_1)
      SentNotification.create_sent_notification(location.id, NOT_ACTIVATED_2)
      SentNotification.create_sent_notification(location.id, NOT_ACTIVATED_3)
    end
  end

  def perform_query_level2(date)
    logger.debug "Start quering locations not activated older than #{date}"
    locations = SentNotificationService.location_not_handled_by(NOT_ACTIVATED_2, false)
    locations.each do |location|
      next if location.user.blank?
      next if location.created_at >= date

      localize(location)
      send_not_activated_mail_level2(location)
      SentNotification.create_sent_notification(location.id, NOT_ACTIVATED_1)
      SentNotification.create_sent_notification(location.id, NOT_ACTIVATED_2)
    end
  end

  def perform_query_level1(date)
    logger.debug "Start quering locations not activated older than #{date}"

    locations = SentNotificationService.location_not_handled_by(NOT_ACTIVATED_2, false)
    locations.each do |location|
      next if location.user.blank?
      next if location.created_at >= date

      localize(location)
      send_not_activated_mail_level1(location)
      SentNotification.create_sent_notification(location.id, NOT_ACTIVATED_1)
    end
  end

  def send_not_activated_mail_level1(location)
    logger.info " * Send not activated mail1 to Location_id: #{location.id} with name #{location.listing_name}"
    NotActivatedMailMailer.with(location: location).first_activation_reminder.deliver_now
  end

  def send_not_activated_mail_level2(location)
    logger.info " * Send not activated mail2 to Location_id: #{location.id} with name #{location.listing_name}"
    NotActivatedMailMailer.with(location: location).second_activation_reminder.deliver_now
  end

  def send_not_activated_mail_level3(location)
    logger.info " * Send not activated mail3 to Location_id: #{location.id} with name #{location.listing_name}"
    NotActivatedMailMailer.with(location: location).last_activation_reminder.deliver_now
  end
end
