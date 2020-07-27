# frozen_string_literal: true

# Service class for location controller
class LocationService
  def initialize(logger)
    @logger = logger
  end

  def destroy(location)
    @logger.debug "Removing location '#{location.listing_name}'',id: #{location.id}"
    location.photos.destroy_all
    location.reviews.destroy_all
    location.reservations.destroy_all
    location.messages.destroy_all
    @logger.info "Removed location ''#{location.listing_name}'',id: #{location.id}"
    location.delete
  end

  # Splits an active record error hash to a single string
  def error_messages_to_s(errors)
    text = '<br>'
    errors.each do |_field, message|
      text = text + message.to_s + '.<br>'
    end
    text
  end

end
