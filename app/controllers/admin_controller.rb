# frozen_string_literal: true

##
# Controls alla admin related data like userlist, venues list, active / inavtive
# sate
class AdminController < ApplicationController
  include CounterHelper
  before_action :authenticate_user!
  before_action :admin?

  def index
    @total_users = User.count
    @total_locations = Location.count
    @total_active_locations = Location.where(active: true).count
    @total_messages = Message.count
    render 'admin/index'
  end

  def users
    @users = User.all.order(:id)
    render 'admin/userlist'
  end

  def locations
    logger.debug("Query with params #{params}")
    if params[:userid]
      logger.debug(' Filter with userid')
      if params[:active] == 'true'
        @locations = Location.where(user_id: params[:userid], active: true)
        .order(:id)
      else
        @locations = Location.where(['user_id= ? and (active = false or active is NULL)',
          params[:userid]])
          .order(:id)
      end
    else
      logger.debug(' Load all locations')
      @locations = Location.all.order(:id)
    end
    CounterHelper.load_total_numbers(@locations)
    render 'admin/locations'
  end

  def recalculation
    ReverseGeolocationJob.perform_later
    redirect_back(fallback_location: request.referer)
  end

  private

  def permitSearchParams(params)
    params.permit(:userid, :active)
  end

  def admin?
    redirect_to root_path unless current_user.isAdmin
  end
end
