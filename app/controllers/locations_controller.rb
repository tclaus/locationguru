class LocationsController < ApplicationController
  before_action :set_location, except: %i[index new create]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorized, only: [:listing, :pricing, :description,
                :photo_upload, :amenities, :location, :update]

  def index
    @locations = current_user.locations
  end

  def new
    @location = current_user.locations.build
  end

  def create
    @location = current_user.locations.build(location_params)
    if @location.save
      redirect_to listing_location_path(@location), notice: 'Saved...'
    else
      flash[:alert] = 'Something went wrong...'
      render :new
    end
  end

  def show; end

  def listing; end

  def pricing; end

  def description; end

  def amenities; end

  def photo_upload
    @photos = @location.photos
  end

  def location; end

  def update
    new_params = location_params
    new_params = location_params.merge(active: true) if set_location_active
    if @location.update(new_params)
      flash[:notice] = 'Updated...'
      redirect_to listing_location_path(@location), notice: 'Updated...'
    else
      flash[:alert] = 'Something went wrong...'
      redirect_back(fallback_location: request.referer)
    end
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def is_authorized
    redirect_to root_path, alert: "You dont have permission" unless current_user.id == @location.user_id
  end

  def set_location_active
    params[:active] && !@location.listing_name.blank? && !@location.photos.blank? && !@location.address.blank?
  end

  def location_params
    params.require(:location).permit(:location_type,
                                     :kind_type,
                                     :room_type,
                                     :price_level,
                                     :listing_name,
                                     :summary,
                                     :address,
                                     :active,
                                     :has_heating,
                                     :has_kitchen,
                                     :has_outdoor,
                                     :has_music_eq,
                                     :has_furniture,
                                     :has_parking_space,
                                     :catering)
  end
end
