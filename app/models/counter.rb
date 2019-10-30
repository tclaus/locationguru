# frozen_string_literal: true

class Counter < ApplicationRecord
  # Increases send mail counter for user id
  def self.increase_mail(user_id)
    # context: mail, type: user_id = user_42

    # Find or create counters
    counter = Counter.where(context: 'mail_send_for_user',
                            context_type: user_id,
                            date_of_count: Date.today).first

    if counter.nil?
      Counter.create(count: 1, context: 'mail_send_for_user', context_type: user_id, date_of_count: Date.today)
    else
      sql = "UPDATE counters SET count = COALESCE(count, 0) + 1
                    WHERE context = 'mail_send_for_user'
                          AND context_type='#{user_id}'
                          AND date_of_count='#{Date.today}'"
      connection.select_value(sql).to_i
    end
  end

  # increases location visits for location id
  def self.increase_location(location_id, client_ip)
    logger.info "Increment location #{location_id} on #{client_ip}"
    last_ip = Redis.current.get("IP-#{location_id}")
    return if last_ip == client_ip

    logger.info " Last known IP: #{last_ip}"
    Redis.current.set("IP-#{location_id}", client_ip)

    # read last IP - if not existent or different than last, then increases
    # Dont increasde if same as current Request IP

    counter = Counter.where(context: 'location_visits_for_user',
                            context_type: location_id,
                            date_of_count: Date.today).first
    if counter.nil?
      Counter.create(count: 1, context: 'location_visits_for_user', context_type: location_id, date_of_count: Date.today)
    else
      sql = "UPDATE counters SET count = count + 1 WHERE context = 'location_visits_for_user' and context_type='#{location_id}' and date_of_count='#{Date.today}'"
      connection.select_value(sql).to_i
    end
    logger.info ' Inrement existing counter'
  end

  def self.load_7days_counts(location_id)
    start_date = (Date.today - 7)
    count_value = Counter.where("context = 'location_visits_for_user' AND context_type='?' AND date_of_count >= ?", location_id, start_date)
                         .group(:context_type)
                         .sum(:count)

    logger.info "Count-value= #{count_value}"
    value = count_value.first[1] unless count_value.empty?
    logger.debug "Value = #{value}"
    value
  end

end
