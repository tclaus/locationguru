class LocationsController < ApplicationController
  before_action :set_location, except: %i[index new create]
  before_action :authenticate_user!, except: [:show]

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

  def photo; end

  def upload; end

  def location; end

  def update
    if @location.update(location_params)
      flash[:notice] = 'Updated...'
    else
      flash[:alert] = 'Something went wrong...'
      redirect_back(fallback_location: request.referer)
    end
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:location_type,
                                     :building_type,
                                     :room_type,
                                     :listing_name,
                                     :summary,
                                     :active)
    # TODO: put properties parameters here!
  end
end
