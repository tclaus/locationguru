# frozen_string_literal: true

require 'tempfile'

##
# Controls alla admin related data like userlist, venues list, active / inavtive
# sate
class AdminController < ApplicationController
  include CounterHelper
  before_action :authenticate_user!
  before_action :admin?

  def index
    @total_confirmed_users = User.where('confirmed_at IS NOT NULL').count
    @total_users = User.count
    @total_locations = Location.count
    @total_active_locations = Location.where(active: true).count
    @total_messages = Message.count
    @insufficient_photos = venues_with_insufficient_photos()
    @new_in_30_days = new_in_30_days()
    render 'admin/index'
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

  def venues_with_insufficient_photos
    # Get locationIds with kless than X photos
    loosers = Photo.group(:location_id).having('count(*) < ?', 3).order(count_all: :asc).count
    # Get locations by its name
    insufficient_photos = []
    loosers.each do |venue_id, count_photos|
        location = Location.find(venue_id)
        insufficient_photos << [location, count_photos] if location.active
      rescue ActiveRecord::RecordNotFound
        # photo without location
        logger.warn("location with ID: #{venue_id} not found, but photo record still exist")
    end
    insufficient_photos
  end

  def new_in_30_days
    Location.where('active = ? and created_at > ?',true, (Date.today - 30.days))
  end

  private

  def permitSearchParams(params)
    params.permit(:userid, :active)
  end

  def admin?
    redirect_to root_path unless current_user.isAdmin
  end
end
