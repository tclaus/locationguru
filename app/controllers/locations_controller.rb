# frozen_string_literal: true

class LocationsController < ApplicationController
  include CounterHelper

  before_action :set_location, except: %i[index new create]
  before_action :authenticate_user!, except: %i[new create preload preview show send_message]
  before_action :authorized?, only: %i[listing description
                                       photo_upload suitables amenities location update destroy]
  before_action :location_is_active, only: %i[send_message]

  def index
    @locations = current_user.locations
    CounterHelper.load_total_numbers(@locations)
  end

  def new
    if user_signed_in?
      @location = current_user.locations.build
    else
      # Attach temporary on system user
      @location = User.system_user.locations.build
    end
  end

  def restrict
    @location.isRestricted = !@location.isRestricted
    @location.save
    render json: { isRestricted: @location.isRestricted }
  end

  def create
    logger.info 'Creating a new location'

    if user_signed_in?
      location = current_user.locations.build(location_params)
    else
      location = User.system_user.locations.build(location_params)
      cookies[:temporary_location_guid] = location.generate_unique_guid
    end

    if location.save
      logger.debug "Created venue with ID #{location.id}"
      redirect_to listing_location_path(location), notice: t('saved')
    else
      logger.warn 'Failed creating a venue: ' + location_service.error_messages_to_s(location.errors)
      flash[:alert] = t('something_went_wrong_create_location') + location_service.error_messages_to_s(location.errors)
      redirect_to new_location_url(location_params)
    end

  end

  def show
    unless @location.active
      if current_user.blank?
        logger.warn "Tried to load inactive location without authorization: #{@location.id}"
        redirect_to(root_path, alert: t('.this_venue_is_not_active')) && return
      end

      if !owner? && !current_user.isAdmin
        logger.warn "Tried to load inactive location without owner or admin role: #{@location.id}"
        redirect_to(root_path, alert: t('.this_venue_is_not_active')) && return
      end
    end
    @photos = @location.photos
    @guest_reviews = @location.reviews
    @weekly_calls = Counter.load_7days_location_visits(@location.id)
    @reviews = @location.reviews

    Counter.increase_location_visit(@location.id, request.remote_ip)
  end

  def suitables; end

  def listing; end

  def pricing; end

  def description; end

  def amenities; end

  def photo_upload
    @photos = @location.photos
  end

  def location; end

  def send_message
    @message = Message.new
    @message.user_id = @location.user_id
    @message.location_id = @location.id
    @message.inquery_date = params[:date]

    unless current_user.blank?
      @message.email = current_user.email
      @message.name = "#{current_user.first_name} #{current_user.last_name}"
    end

    logger.debug "Sent message with params: #{params}"
  end

  def update
    new_params = location_params
    new_params = location_params.merge(active: true) if set_location_active
    old_status = @location.active
    if @location.update(new_params)
      logger.debug "Updated location with ID #{@location.id}"

      # Sent status change mail
      if old_status != @location.active
        if @location.active == true
          # Set a flash 'Aktivated'
          # Send Your locations is activated mail
          flash[:notice] = t('your_location_is_now_active')
          LocationMailer
            .with(location: @location)
            .location_activated
            .deliver_later
        else
          flash[:notice] = t('your_location_is_now_inactive')
          LocationMailer
            .with(location: @location)
            .location_deactivated
            .deliver_later
        end
      else
        redirect_to description_location_path(@location), notice: t('updated')
        return
      end
      redirect_to description_location_path(@location)
      return
    else
      logger.debug "Failed updating a location. #{@location.errors.messages}"
      flash[:alert] = t('something_went_wrong_create_location') +
                      location_service.error_messages_to_s(@location.errors)
      redirect_back(fallback_location: request.referer)
    end
  end

  # load inavaible dates to frontent
  def preload
    today = Date.today
    reservations = @location.reservations
                            .where(
                              'start_date >= ? ', today
                            )
                            .select('id, status, start_date')

    render json: reservations
  end

  def preview
    # Check if is reserverd
    start_date = Date.parse(params[:start_date])
    output = {
      status: reservation_status(start_date, @location)
    }
    render json: output
  end

  def destroy
    logger.debug "Delete location with id: #{params}"
    location = Location.find params[:id]
    if !location.nil?
      location_service.destroy(location)
      flash[:notice] = t('.location_deleted')
    else
      flash[:notice] = t('.could_not_delete_this_location')
    end
    redirect_back(fallback_location: request.referer) if request.referer
  end

  private

  def location_service
    @location_service ||= LocationService.new(logger)
  end

  def owner?
    return false if current_user.blank?

    current_user.id == @location.user_id
  end

  # Is selected date in conflict with other reservations?
  #
  def reservation_status(start_date, location)
    check = location.reservations.where('start_date = ? ', start_date)

    return 'free' if check.empty?

    check.first.status
  end

  def set_location
    @location = Location.find(params[:id])
  end

  def authorized?
    unless (current_user.id == @location.user_id) || current_user.isAdmin
      redirect_to root_path,
                  alert: t('not_authorized')
    end
  end

  def set_location_active
    params[:active] && !@location.listing_name.blank? && !@location.photos.blank? && !@location.address.blank?
  end

  def location_is_active
    logger.debug ' Check location is active'
    redirect_to root_path, alert: t('location_inactive') unless @location.active
  end

  def location_params
    params.require(:location).permit(:location_type,
                                     :kind_type,
                                     :room_type,
                                     :max_persons,
                                     :price_level,
                                     :listing_name,
                                     :subtitle,
                                     :summary,
                                     :address,
                                     :phonenumber,
                                     :email,
                                     :website,
                                     :active,
                                     :has_heating,
                                     :has_kitchen,
                                     :has_outdoor,
                                     :has_music_eq,
                                     :has_furniture,
                                     :has_parking_space,
                                     :catering,
                                     :isForPrivateParties,
                                     :isForClubbing,
                                     :isForWeddings,
                                     :isForPhotoFilm,
                                     :isForBusiness,
                                     :isForEscapeRoomGames,
                                     :isForConferences,
                                     :isForBachelorParties,
                                     :isForChristmasParties,
                                     :suitableForText)
  end
end
