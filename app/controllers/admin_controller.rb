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
    venues_with_insufficient_photos
    render 'admin/index'
  end

  def users
    @users = User.all.order(:id)
    render 'admin/userlist'
  end

  def export_users
    file = export_service.file_user_list
    send_file file, type: 'text/csv', disposition: 'attachment', filename: 'exported_userlist.csv'
  end

  def export_messages
    file = export_service.file_message_list
    send_file file, type: 'text/csv', disposition: 'attachment', filename: 'exported_message_sender_list.csv'
  end

  # Render list of venues
  def locations
    @locations = Location.all.order(id: :desc)
    CounterHelper.load_total_numbers(@locations)
    render 'admin/locations'
  end

  # Render list of active venues
  def active_locations
    @locations = Location.activated.order(id: :desc)
    CounterHelper.load_total_numbers(@locations)
    render 'admin/locations'
  end

  def messages
    @messages = Message.all.order(id: :desc)
    render 'admin/messages'
  end

  # Stars a recalculation of geoinformation of all locations
  def recalculation
    ReverseGeolocationJob.perform_later
    redirect_back(fallback_location: request.referer)
  end

  private

  # Aggregate statistics about users
  def aggregate_users
    @total_users = User.count
    @total_confirmed_users = User.where('confirmed_at IS NOT NULL').count
    @total_confirmed_users_diff = admin_service.confirmed_user_diff
  end

  # Aggregate statistics about locations
  def aggregate_locations
    @total_locations = Location.count
    @total_active_locations = Location.activated.count
    @total_active_locations_diff = admin_service.active_location_diff
    @latest_locations = latest_locations(30)
    @top_requested_locations = top_requested_locations(90)
  end

  # Locations with most requests in last 90 days ( most booked events in past)
  def top_requested_locations(days)
    admin_service.top_requested_locations(days)
  end

  def latest_locations(days)
    Location.where('active = ? and created_at > ?', true, (Date.today - days))
  end

  # Locatins with to few photos. Request to improve
  def venues_with_insufficient_photos
    @insufficient_photos = admin_service.venues_with_insufficient_photos(3)
  end

  def aggregate_messages
    @total_messages = Message.count
    @total_messages_diff = @total_messages - Message.where('created_at < ?', one_week_ago).count
  end

  def export_service
    @export_service ||= ExportService.new
  end

  def admin_service
    @admin_service ||= AdminService.new(logger)
  end

  def one_week_ago
    Date.today - 7.days
  end

  def admin?
    redirect_to root_path unless current_user.isAdmin
  end
end
