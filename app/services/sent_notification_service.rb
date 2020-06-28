# frozen_string_literal: true

# Helps handling mnonitoring which notification was already send
class SentNotificationService
  # Returns all activated or inactivated locations which have not a notification
  # marker of reason:
  def self.location_not_handled_by(reason, activated)
    Location.find_by_sql(["select locations.* from locations where locations.active = ? and locations.id not in (
  select target_location_id from sent_notifications where sent_notifications.reason = ?)",
                          activated, reason])
  end

end
