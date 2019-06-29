# frozen_string_literal: true

class Counter < ApplicationRecord
  # Increases send mail counter for user id
  def self.increase_mail(user_id)
    # context: mail, type: user_id = user_42

    # Find or create counters
    counter = Counter.where(context: 'mail_send_for_user', context_type: user_id, date_of_count: Date.today).first
    if counter.nil?
      Counter.create(count: 1, context: 'mail_send_for_user', context_type: user_id, date_of_count: Date.today)
    else
      counter.count += 1
      counter.save!
    end
  end

  # increases location visits for location id
  def self.increase_location(location_id)
    logger.info 'Increase location'
    # context : location, type: location_id
    counter = Counter.where(context: 'location_visits_for_user', context_type: location_id, date_of_count: Date.today).first
    if counter.nil?
      Counter.create(count: 1, context: 'location_visits_for_user', context_type: location_id, date_of_count: Date.today)
      logger.info 'Create location'
    else
      counter.count += 1
      counter.save!
      logger.info 'Increment location'
    end
  end

  def self.load_7days_counts(location_id)
    start_date = (Date.today - 7)
    count_value = Counter.where("context = 'location_visits_for_user' AND context_type='?' AND date_of_count >= ?", location_id, start_date)
                         .group(:id)
                         .sum(:count)

    return count_value.first[1] unless count_value.empty?
    return 0
  end

end
