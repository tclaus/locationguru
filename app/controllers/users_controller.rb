class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @locations = @user.locations
  end
end
