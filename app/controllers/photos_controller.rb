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
    @photo.destroy
    @photos = Photo.where(location_id: @location.id)

    respond_to :js
  end
end
