class ReverseGeolocationJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Walk through all locations and update its geolocation.

    logger.debug 'Start Recalculation of geocoordinates'
    Location.all.each do |location|
      if !location.geocoded? && location.address?
        logger.debug "Processing not geocoded location #{location.id}: #{location.listing_name}"
        location.geocode
        location.save
      end
      if location.geocoded?
        logger.debug "Processing reverse geocode #{location.id}: #{location.listing_name}"
        location.reverse_geocode
        location.save
      end
    end
  end
end
