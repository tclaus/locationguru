# frozen_string_literal: true

# Sends a mail to all venues with insufficient photos
class SendNotificationOnPhotosJob < ApplicationJob
  queue_as :default
  REASON = 'insufficient photos'

  def perform(*_args)
    send_information_on_photos
  end

  private

  def send_information_on_photos
    venue_photo_pairs = admin_service.venues_with_insufficient_photos(3)
    # loop and send to owner a messages
    # mark that first mesage is send
    logger.info("Found #{venue_photo_pairs.count} venues with too less photos. Send a reminder mail to everyone.")
    venue_photo_pairs.each do |venue_photo_pair|
      venue = venue_photo_pair[0]
      notification = SentNotification.find_by(target_location_id: venue.id, reason: REASON)
      if notification.blank?
        send_mail(venue)
        SentNotification.create(target_location_id: venue.id, reason: REASON)
      end
    end
  end

  def admin_service
    @admin_service ||= AdminService.new(logger)
  end

  def send_mail(location)
    logger.info " * Send mail for too less photos: #{location.id} with name #{location.listing_name}"
    localize(location)
    InsufficientPhotosMailer.with(location: location).send_mail.deliver_now
  end
end
