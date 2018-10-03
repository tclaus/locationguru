require 'simpleLocation'

class PagesController < ApplicationController

  # Show only unrestriced locations on main Page
  def home
    @locations = Location.where(active: true, isRestricted: false)
      .order('RANDOM()').limit(3)
    @cities = cities.sample(4)
  end

  def search
    logger.debug "* Search Params: #{params}"
    if params[:search].present? && params[:search].strip != ''
      session[:loc_search] = params[:search]
    end

    if session[:loc_search] && session[:loc_search] != ''
      logger.debug " *Location query on geocordinates"
      locations = Location.where(active: true)
                                   .near(session[:loc_search], 15, order: 'distance')
    end

    if locations.blank?
      logger.debug " *Location query with like on name"
      locations = Location.where("active = true and listing_name ilike ?", "%#{session[:loc_search]}%")
      logger.debug "Found in names: #{locations.count}"
    end

    if locations.blank?
      # If no location and no direct hit, return all locations ( Need to better fetch from database)
      logger.debug " *Simply return all locations"
      locations = Location.where(active: true).all
    end


    # Step 3 - Ransack filters in memory other data (Ameni)
    #          maybe too much data in future!

    @search = Location.ransack(params[:q])
    @locations = @search.result
    @simpleLocations = createSimpleLocations(@locations)
  end

  def cities
    cities_ = [{ query: 'search?utf8=✓&search=Dortmund+-+Germany',
                 name: 'Dortmund',
                 folderName: 'dortmund',
                 imageName: 'dortmund.jpg' },
               { query: 'search?utf8=✓&search=Berlin+-+Germany',
                 name: 'Berlin',
                 folderName: 'berlin',
                 imageName: 'berlin.jpg' },
               { query: 'search?utf8=✓&search=bochum+-+Germany',
                 name: 'Bochum',
                 folderName: 'bochum',
                 imageName: 'bochum.jpg' },
               { query: 'search?utf8=✓&search=Dresden+-+Germany',
                 name: 'Dresden',
                 folderName: 'dresden',
                 imageName: 'dresden.jpg' },
               { query: 'search?utf8=✓&search=düsseldorf+-+Germany',
                 name: 'Düsseldorf',
                 folderName: 'duesseldorf',
                 imageName: 'duesseldorf.jpg' },
               { query: 'search?utf8=✓&search=Freiburg+-+Germany',
                 name: 'Freiburg',
                 folderName: 'freiburg',
                 imageName: 'freiburg.jpg' },
               { query: 'search?utf8=✓&search=Heidelberg+-+Germany',
                 name: 'Heidelberg',
                 folderName: 'heidelberg',
                 imageName: 'heidelberg.jpg' },
               { query: 'search?utf8=✓&search=Heidelberg+-+Germany',
                 name: 'Heidelberg',
                 folderName: 'heidelberg',
                 imageName: 'heidelberg1.jpg' },
               { query: 'search?utf8=✓&search=Köln+-+Germany',
                 name: 'Köln',
                 folderName: 'koeln',
                 imageName: 'koeln.jpg' },
               { query: 'search?utf8=✓&search=Lauffen+am+Neckar%2C+Germany',
                 name: 'Lauffen am Neckar',
                 folderName: 'laufen_am_neckar',
                 imageName: 'laufen_am_neckar.jpg' },
               { query: 'search?utf8=✓&search=München+-+Germany',
                 name: 'München',
                 folderName: 'muenchen',
                 imageName: 'muenchen.jpg' },
               { query: 'search?utf8=✓&search=Warstein+-+Germany',
                 name: 'Warstein',
                 folderName: 'warstein',
                 imageName: 'warstein.jpg' },
               { query: 'search?utf8=✓&search=Zandvoort%2C+Netherlands',
                 name: 'Zandvoort',
                 folderName: 'zandvoort',
                 imageName: 'zandvoort.jpg' }]

    cities_
  end

  # from this folder - pic a image
  def pic_a_file(folderName); end
end
