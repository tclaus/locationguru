# frozen_string_literal: true

require 'tempfile'

##
# Controls all admin related data like userlist, venues list, active / inavtive
# state
class AdminController < ApplicationController
  include CounterHelper

  before_action :authenticate_user!
  before_action :admin?

  def index

    aggregate_users
    aggregate_locations
    aggregate_messages

    @insufficient_photos = venues_with_insufficient_photos

    render 'admin/index'
  end

  # Aggregate statistics about users
  def aggregate_users
    @total_users = User.count
    @total_confirmed_users = User.where('confirmed_at IS NOT NULL').count
    @total_confirmed_users_diff = confirmed_user_diff
  end

  # Aggregate statistics about locations
  def aggregate_locations
    @total_locations = Location.count
    @total_active_locations = Location.where(active: true).count
    @total_active_locations_diff = active_location_diff
    @latest_locations = latest_locations(30)
    @top_requested_locations = top_requested_locations(90)
  end

  # Returns the active location diff from last week to current week
  def active_location_diff
    year = Date.today.year
    week = Date.today.cweek
    current_count = Counter.total_active_location_count_in(year, week)
    if week > 1
      week -= 1
    else
      week = 52
      year -= 1
    end
    last_week_count = Counter.total_active_location_count_in(year, week)
    current_count - last_week_count
  end

  # Returns the active location diff from last week to current week
  def confirmed_user_diff
    year = Date.today.year
    week = Date.today.cweek
    current_count = Counter.total_active_user_count_in(year, week)
    if week > 1
      week -= 1
    else
      week = 52
      year -= 1
    end
    last_week_count = Counter.total_active_user_count_in(year, week)
    current_count - last_week_count
  end

  def aggregate_messages
    @total_messages = Message.count
    @total_messages_diff = @total_messages - Message.where('created_at < ?', one_week_ago).count
  end

  def one_week_ago
    Date.today - 3.days
  end

  def users
    @users = User.all.order(:id)
    render 'admin/userlist'
  end

  def export_users
    # Export file
    # all with valid mail addrss
    users = User.where('confirmed_at IS NOT NULL').order(:id)
    file = Tempfile.new('exported_userlist')
    users.each do |user|
      file << user.email << ','
      file << user.first_name << ','
      file << user.last_name << ','
      file << user.language_id << ','
      file << 'Location_Provider' << "\n"
    end
    file.flush
    send_file file, type: 'text/csv', disposition: 'attachment', filename: 'exported_userlist.csv'
  end

  # Render list of active or inactive locations 
  def locations
    logger.debug("Query with params #{params}")
    if params[:userid]
      logger.debug(' Filter with userid')
      if params[:active] == 'true'
        @locations = Location.where(user_id: params[:userid], active: true)
        .order(id: :desc)
      else
        @locations = Location.where(['user_id= ? and (active = false or active is NULL)',
          params[:userid]])
                            .order(id: :desc)
      end
    else
      logger.debug(' Load all locations')
      @locations = Location.all
                           .order(id: :desc)
    end
    CounterHelper.load_total_numbers(@locations)
    render 'admin/locations'
  end

  def messages
    # TODO: Make this in pages! Currently its OK
    @messages = Message.all.order(id: :desc)
    render 'admin/messages'
  end

  def export_messages
    # Export file
    # all with valid mail addrss
    messages = Message.all.order(:id)
    file = Tempfile.new('exported_messageslist')
    messages.each do |message|
      file << message.email << ','
      file << message.name << ','
      file << 'Message_Senders' << "\n"
    end
    file.flush
    send_file file, type: 'text/csv', disposition: 'attachment', filename: 'exported_message_sender_list.csv'
  end

  def recalculation
    ReverseGeolocationJob.perform_later
    redirect_back(fallback_location: request.referer)
  end

  def latest_venues
    @last_venues = Location.where(active: true)
                        .order(id: :desc)
                        .limit(10)
  end

  # Locatins with to few photos. Request to improve
  def venues_with_insufficient_photos
    # Get locationIds with less than X photos
    loosers = Photo.group(:location_id)
                   .having('count(*) < ?', 3)
                   .order(count_all: :asc)
                   .count
    # Get locations by its name
    insufficient_photos = []
    loosers.each do |location_id, count_photos|
      location = Location.find(location_id)
      insufficient_photos << [location, count_photos] if location.active
    rescue ActiveRecord::RecordNotFound
      # photo without location
      logger.warn("Location with ID: #{location_id} not found, but photo record still exist")
    end
    insufficient_photos
  end

  def latest_locations(days = 30)
    Location.where('active = ? and created_at > ?', true, (Date.today - days))
  end

  # Locations with most requests in last 90 days ( most booked events in future)
  def top_requested_locations(days = 90)
    top_requested = Message.where('created_at > ?', (Date.today - days))
                           .group(:location_id)
                           .order(count_all: :desc)
                           .count
    locations = []
    top_requested.each do |location_id, count_messages|
      location = Location.find(location_id)
      locations << [location, count_messages] if location.active
    rescue ActiveRecord::RecordNotFound
      # Message without location
      logger.warn("Location with ID: #{location_id} not found, but message record still exist")
    end
    locations
  end

  private

  def permitSearchParams(params)
    params.permit(:userid, :active)
  end

  def admin?
    redirect_to root_path unless current_user.isAdmin
  end
end
