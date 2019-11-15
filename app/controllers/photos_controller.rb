# frozen_string_literal: true

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

  # Sets or removes the main photo flag
  def main_photo
    @location = Location.find(params[:location_id])
    return unless @location && current_user.id == @location.user.id

    main_photo_id = params[:photo_id].to_i

    photos = @location.photos
    photos.each do |photo|
      photo.is_main = photo.id == main_photo_id
      photo.save
    end
    respond_to :js
    # render status: :OK
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
      flash[:alert] = 'not allowed to delete photo'
      render status: :not_found
    end
  end
end
