class LocationsController < ApplicationController
  before_action :set_location, except: %i[index new create]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorized, only: %i[listing pricing description
                                         photo_upload suitables amenities location update destroy]

  def index
    @locations = current_user.locations
  end

  def new
    @location = current_user.locations.build
  end

  def create
    logger.debug 'Creating a location'
    @location = current_user.locations.build(location_params)
    if @location.save
      logger.debug "Created location with ID #{@location.id}"
      redirect_to listing_location_path(@location), notice: t('saved')
    else
      logger.debug 'Failed creating a location'
      puts @location.errors.messages.to_s
      flash[:alert] = t('something_went_wrong_create_location') + error_messages_to_s(@location.errors)
      render :new
    end
  end

  def show
    @photos = @location.photos
    @guest_reviews = @location.guest_reviews

    unless @location.active
      if !current_user.blank?
        if !is_owner && !current_user.isAdmin
          logger.warn "Tried to load inactive location without owner or admin role: #{@location.id}"
          redirect_to root_path
        end
      else
        logger.warn "Tried to load inactive location without authorization: #{@location.id}"
        redirect_to root_path
      end
    end
  end

  def suitables
  end

  def listing; end

  def pricing; end

  def description; end

  def amenities; end

  def photo_upload
    @photos = @location.photos
  end

  def location; end

  def send_message
      @message = current_user.messages.build
      @message.location_id = @location.id
      
  end


  def update
    new_params = location_params
    new_params = location_params.merge(active: true) if set_location_active
    if @location.update(new_params)
      logger.debug "Updated location with ID #{@location.id}"
      flash[:notice] = t('updatedLocation')
      redirect_to description_location_path(@location), notice: t('updated')
    else
      logger.debug 'Failed updating a location'
      puts @location.errors.messages.to_s
      flash[:alert] = t('something_went_wrong_create_location') + error_messages_to_s(@location.errors)
      redirect_back(fallback_location: request.referer)
    end
  end

  def preload
    # Pass back to client
    today = Date.today
    reservations = @location.reservations.where(
      'start_date >= ? OR end_date >= ? ', today, today
    )

    render json: reservations
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    output = {
      conflict: is_conflict(start_date, end_date, @location)
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

  # Splits an active recors error hash to a single string
  def error_messages_to_s(errors)
    text = '<br>'
    errors.each do |_field, message|
      text = text + message.to_s + '.<br>'
    end
    text
  end

  def is_owner
    return false if current_user.blank?

    return true if current_user.id == @location.user_id
    false
  end

  def is_conflict(start_date, end_date, location)
    check = location.reservations.where('? < start_date AND end_date < ? ', start_date, end_date)
    !check.empty?
  end

  def set_location
    @location = Location.find(params[:id])
  end

  def is_authorized
    redirect_to root_path, alert: t('not_authorized') unless (current_user.id == @location.user_id) || current_user.isAdmin
  end

  def set_location_active
    params[:active] && !@location.listing_name.blank? && !@location.photos.blank? && !@location.address.blank?
  end

  def location_params
    params.require(:location).permit(:location_type,
                                     :kind_type,
                                     :room_type,
                                     :max_persons,
                                     :price_level,
                                     :listing_name,
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
