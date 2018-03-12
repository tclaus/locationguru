class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :isAdmin

  def index
    @totalUsers = User.count
    @totalLocations = Location.count
    @totalActiveLocations = Location.where(active: true).count
    render "admin/index"
  end

def show

end

  private

  def isAdmin
    if !current_user.isAdmin
      redirect_to root_path
    end
  end
end
