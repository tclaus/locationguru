# frozen_string_literal: true

require 'simple_location'

##
# Top level class
class PagesController < ApplicationController
  # Show only unrestriced locations on main Page
  def home
    @locations = random_locations
    @recent_locations = Location.where(active: true, isRestricted: false)
                                .order(:created_at)
                                .reverse_order
                                .limit(3)
  end

  def random_locations
    sql = 'SELECT * from LOCATIONS WHERE active = true AND "isRestricted" = false ORDER BY Random() LIMIT 3'
    Location.find_by_sql(sql)
  end

  def search
    if params[:search].present? && params[:search].strip != ''
      session[:loc_search] = params[:search]
    end

    if session[:loc_search] && session[:loc_search] != ''
      logger.debug " * Location query on geocordinates with #{session[:loc_search]}"
      locations = Location.where(active: true)
                          .near(session[:loc_search], 15, order: 'distance')
      # logger.debug " Found in geocordinates: #{locations.count(:all)}"
    end

    if locations.blank?
      logger.debug ' * Location query with like on name'
      locations = Location.where('active = true and listing_name ilike ?', "%#{session[:loc_search]}%")
      # logger.debug " Found in names: #{locations.count(:all)}"
    end

    if locations.blank?
      # Show "No found page"
      # Redirect is handled in View'
    end

    # Step 3 - Ransack filters in memory other data (Ameni)
    #          maybe too much data in future!
    @search = locations.ransack(params[:q])
    @locations = @search.result
    @simple_locations = create_simple_locations(@locations)
  end
end
