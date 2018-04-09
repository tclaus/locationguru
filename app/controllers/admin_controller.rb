class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :isAdmin

  def index
    @totalUsers = User.count
    @totalLocations = Location.count
    @totalActiveLocations = Location.where(active: true).count
    render "admin/index"
  end

  def users
    @users = User.all.order(:id)
    render "admin/userlist"
  end

  def locations
    logger.debug("Query with params #{params}")
    if params[:userid]
      logger.debug(" Filter with userid")
      @locations = Location.where({user_id: params[:userid], active: params[:active] }).order(:id)
    else
      logger.debug(" Load all locations")
      @locations = Location.all.order(:id)
    end
    render "admin/locations"
  end

  private

  def permitSearchParams(params)
    params.permit(:userid, :active)
  end

  def isAdmin
    if !current_user.isAdmin
      #ä todo flash message
      redirect_to root_path
    end
  end
end
