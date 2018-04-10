class ReverseGeolocationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Walk through all locations and update its geolocation.

    logger.debug "Start Recalculation of geocooridnates"
    Location.all.each do |location|
      if !location.geocoded?
        logger.debug "Processing #{location.id}: #{location.listing_name}"
        location.reverse_geocode
        location.save
      end
    end



  end
end
