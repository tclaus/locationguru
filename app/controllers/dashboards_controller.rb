class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @locations = current_user.locations
    # Messages, sortirt nach locations
    # group by locationId, where user_id = ICH, order by created_at

    @messages_overview = groupded_messages
    @unreadMessageCount = unreadMessageCount
  end

private
  def unreadMessageCount
    Message
    .where(user_id: current_user.id, isRead: false)
    .count()
  end

  def groupded_messages

    Message
    .select('messages.id as id, messages.email as email, messages.name as name, messages.message as message, messages."isRead" as is_read, locations.id as location_id, locations.listing_name as listing_name, messages.created_at as created_at')
    .joins(:location)
    .where("messages.user_id = ?",current_user.id)
    .order("messages.created_at desc")

  end

end
