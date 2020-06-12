# frozen_string_literal: true

class LocationsController < ApplicationController
  include CounterHelper

  before_action :set_location, except: %i[index new create]
  before_action :authenticate_user!, except: %i[preload preview show send_message]
  before_action :is_authorized, only: %i[listing description
                                         photo_upload suitables amenities location update destroy]
  before_action :location_is_active, only: %i[send_message]

  def index
    @locations = current_user.locations
    CounterHelper.load_total_numbers(@locations)
  end

  def new
    @location = current_user.locations.build
  end

  def restrict
    @location.isRestricted = !@location.isRestricted
    @location.save
    render json: { isRestricted: @location.isRestricted }
  end

  def create
    logger.debug 'Creating a location'
    @location = current_user.locations.build(location_params)
    if @location.save
      logger.debug "Created location with ID #{@location.id}"
      redirect_to listing_location_path(@location), notice: t('saved')
    else
      logger.warn 'Failed creating a location: ' + error_messages_to_s(@location.errors)
      flash[:alert] = t('something_went_wrong_create_location') + error_messages_to_s(@location.errors)
      redirect_to new_location_url(location_params)
    end
  end

  def show
    @photos = @location.photos
    @guest_reviews = @location.guest_reviews
    @weekly_calls = Counter.load_7days_location_visits(@location.id)

    unless @location.active
      if !current_user.blank?
        if !owner? && !current_user.isAdmin
          logger.warn "Tried to load inactive location without owner or admin role: #{@location.id}"
          redirect_to root_path
        end
      else
        logger.warn "Tried to load inactive location without authorization: #{@location.id}"
        redirect_to root_path
      end
    end
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

    logger.debug "Send message with params: #{params}"
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
            .with(location: @location,
                  edit_url: listing_location_url(@location),
                  show_url: location_url(@location)).location_activated.deliver_later
        else
          # Set a flash 'Deaktivated
          # Send Your locations is deactivated mail
          flash[:notice] = t('your_location_is_now_inactive')
          LocationMailer
            .with(location: @location,
                  edit_url: listing_location_url(@location),
                  show_url: location_url(@location)).location_deactivated.deliver_later
        end
      else
        redirect_to description_location_path(@location), notice: t('updated')
        return
      end
      redirect_to description_location_path(@location)
      return
    else
      logger.debug "Failed updating a location. #{@location.errors.messages}"
      flash[:alert] = t('something_went_wrong_create_location') + error_messages_to_s(@location.errors)
      redirect_back(fallback_location: request.referer)
    end
  end

  def preload
    # load inavaible dates to frontent
    logger.debug 'Preload available dates'
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
      logger.debug "Remove location '#{location.listing_name}'',id: #{location.id}"
      location.photos.destroy_all
      location.guest_reviews.destroy_all
      location.reservations.destroy_all
      logger.debug "Remove location ''#{location.listing_name}'',id: #{location.id}"
      location.delete
      flash[:notice] = t('.location_deleted')
    else
      flash[:notice] = t('.could_not_delete_this_location')
    end
    redirect_back(fallback_location: request.referer) if request.referer
  end

  private

  # Splits an active record error hash to a single string
  def error_messages_to_s(errors)
    text = '<br>'
    errors.each do |_field, message|
      text = text + message.to_s + '.<br>'
    end
    text
  end

  def owner?
    return false if current_user.blank?

    return true if current_user.id == @location.user_id

    false
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

  def is_authorized
    redirect_to root_path,
      alert: t('not_authorized') unless (current_user.id == @location.user_id) || current_user.isAdmin
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
