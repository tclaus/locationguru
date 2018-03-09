class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @locations = @user.activeLocations

    #Display all the guest Reviews to host
    @guest_reviews = Review.where(type: "GuestReview", host_id: @user.id)

    @host_reviews = Review.where(type: "HostReview", guest_id: @user.id)
  end

  def avatar

     logger.info "* Received new Avatar!"
     @user = current_user
     @user.avatar = avatar_user_params[:avatar]
     @user.save
     redirect_back(fallback_location: request.referer, notice: t('saved'))
  end

protected
  def avatar_user_params
    params.require(:user).permit(:avatar)
  end

end
