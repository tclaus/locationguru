class PhotosController < ApplicationController

  def create
    @location = Location.find(params[:location_id])
    return unless params[:images]
    params[:images].each do |img|
      @location.photos.create(image: img)
    end

    @photos = @location.photos
    redirect_back(fallback_location: request.referer, notice: t('saved'))
  end

  def destroy
    @photo = Photo.find(params[:id])
    @location = @photo.location
    if !current_user.blank? && current_user.id == @location.user.id
      logger.debug "Delete photo #{@photo.id}"
      @photo.destroy
      @photos = Photo.where(location_id: @location.id)

      respond_to :js
    else
      logger.debug "Not allowed to delete photo #{@photo.id}"
      flash[:alert] = "not allowed to delete photo"
      render status: :not_found
    end
  end
end
