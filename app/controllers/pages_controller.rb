class PagesController < ApplicationController

  def home
    @locations = Location.where(active: true).limit(3)
  end

  def search
    logger.debug "Params: #{params}"
    if params[:search].present? && params[:search].strip != ""
      session[:loc_search] = params[:search]
    end

  if session[:loc_search] && session[:loc_search] != ""
    @locations_address  =Location.where(active: true).near(session[:loc_search], 5, order: 'distance')
  else
    # If no location, return all locations ( Need to better fetch from database)
    @locations_address = Location.where(active: true).all
  end

  # Step 3 - Ransack filters in memory other data (Ameni)
  #          maybe too much data in future!
  @search = @locations_address.ransack(params[:q])
  @locations = @search.result

  end

end
