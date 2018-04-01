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

# Todo: show locations
# Name, aktiv / Inaktiv
# Name des Erstellers

  private

  def isAdmin
    if !current_user.isAdmin
      redirect_to root_path
    end
  end
end
