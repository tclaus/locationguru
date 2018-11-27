# frozen_string_literal: true

class Counter < ApplicationRecord
  # Increases send mail counter for user id
  def self.increase_mail(user_id)
    # context: mail, type: user_id = user_42
    year = Time.current.year
    month = Time.current.month
    day = Time.current.day
    # Find or create counters
    counter = Counter.where(context: 'mail_send_for_user', context_type: user_id, year: year, month: month, day: day).first
    if counter.nil?
      Counter.create(count: 1, context: 'mail_send_for_user', context_type: user_id, year: year, month: month, day: day)
    else
      counter.count += 1
      counter.save!
    end
  end

  # increases location visits for location id
  def self.increase_location(location_id)
    logger.info 'Increase location'

    year = Time.current.year
    month = Time.current.month
    day = Time.current.day
    # context : location, type: location_id
    counter = Counter.where(context: 'location_visits_for_user', context_type: location_id, year: year, month: month, day: day).first
    if counter.nil?
      Counter.create(count: 1, context: 'location_visits_for_user', context_type: location_id, year: year, month: month, day: day)
      logger.info 'Create location'
    else
      counter.count += 1
      counter.save!
      logger.info 'Increment location'
    end
  end
end
