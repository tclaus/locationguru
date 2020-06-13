# frozen_string_literal: true

# Supports the admin_controller
class AdminService
  def initialize(logger)
    @logger = logger
  end

  # Get locationIds with less than X photos
  def venues_with_insufficient_photos(min_photos)
    loosers = Photo.group(:location_id)
                   .having('count(*) < ?', min_photos)
                   .order(count_all: :asc)
                   .count
    # Get locations by its name
    insufficient_photos = []
    loosers.each do |location_id, count_photos|
      location = Location.find_by_id(location_id)
      if location
        insufficient_photos << [location, count_photos] if location.active
      else
        # photo without location
        @logger.warn("Venue with Id: #{location_id} not found, but photo record still exist")
      end
    end
    insufficient_photos
  end

  # Returns the most requested location with the most request in the recent time
  def top_requested_locations(days)
    top_requested = Message.where('created_at > ?', (Date.today - days))
                           .group(:location_id)
                           .order(count_all: :desc)
                           .count
    locations = []
    top_requested.each do |location_id, count_messages|
      location = Location.find_by_id(location_id)
      if location
        locations << [location, count_messages] if location.active
      else
        # Message without location
        @logger.warn("Venue with ID: #{location_id} not found, but message record still exist")
      end
    end
    locations
  end

  # Returns the active location diff from last week to current week
  def active_location_diff
    today = Date.today
    year = today.year
    week = today.cweek
    current_count = Counter.total_active_location_count_in(year, week)
    last_week = today - 7.days
    year = last_week.year
    week = last_week.cweek
    last_week_count = Counter.total_active_location_count_in(year, week)
    current_count - last_week_count
  end

  # Returns the active location diff from last week to current week
  def confirmed_user_diff
    today = Date.today
    year = today.year
    week = today.cweek
    current_count = Counter.total_active_user_count_in(year, week)
    last_week = today - 7.days
    year = last_week.year
    week = last_week.cweek
    last_week_count = Counter.total_active_user_count_in(year, week)
    current_count - last_week_count
  end
end
