# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @locations = current_user.locations
    # Messages, sortiert nach locations
    # group by locationId, where user_id = ICH, order by created_at

    @messages_overview = groupded_messages
    @unread_message_count = unread_message_count
  end

  def unread_message_count_json
    render json: unread_message_count
  end

  def unread_message_count
    Message
      .where(user_id: current_user.id, isRead: false)
      .count
  end

  def groupded_messages
    Message
      .includes(:location)
      .where('messages.user_id = ?', current_user.id)
      .order('messages.created_at desc')
  end
end
