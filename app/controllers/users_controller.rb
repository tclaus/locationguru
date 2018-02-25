class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @locations = @user.activeLocations

    #Display all the guest Reviews to host
    @guest_reviews = Review.where(type: "GuestReview", host_id: @user.id)

    @host_reviews = Review.where(type: "HostReview", guest_id: @user.id)
  end
end
