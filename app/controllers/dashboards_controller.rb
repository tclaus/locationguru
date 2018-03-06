class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @locations = current_user.locations
  end
end
