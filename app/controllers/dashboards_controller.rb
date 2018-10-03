class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @locations = current_user.locations
    # Messages, sortiert nach locations
    # group by locationId, where user_id = ICH, order by created_at

    @messages_overview = groupded_messages
    @unreadMessageCount = unreadMessageCount
  end

  def unreadMessageCountJSON
    render json: unreadMessageCount
  end

private

def unreadMessageCount
  Message
  .where(user_id: current_user.id, isRead: false)
  .count()
end

  def groupded_messages

    Message
    .includes(:location)
    .where("messages.user_id = ?",current_user.id)
    .order("messages.created_at desc")

  end

end
