# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
    @locations = @user.activeLocations

    # Display all the guest Reviews to host
    @guest_reviews = Review.where(type: 'GuestReview', host_id: @user.id)

    @host_reviews = Review.where(type: 'HostReview', guest_id: @user.id)
  end

  # Sets an avater / averrides setting from gravatar
  def avatar
    logger.info '* Received new Avatar!'
    @user = current_user
    @user.avatar = avatar_user_params[:avatar]
    @user.save
    redirect_back(fallback_location: request.referer, notice: t('saved'))
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    logger.debug "Delete user: #{@user.id}"
    redirect_to admin_users_path
  end

  def update_phone_number
    current_user.update_attributes(user_params)
    if !user_params[:phone_number].blank?
      current_user.generate_pin
      current_user.send_pin(t('.SMS_YourPin'))
    else
      current_user.pin = ''
      current_user.save
    end
    # TODO: Can the phone number be checked?
    redirect_to edit_user_registration_path, notice: 'Saved...'
  rescue Exception => e
    logger.error e.inspect.to_s
    logger.error "Error sending pin: #{e.message}"
    redirect_to edit_user_registration_path, alert: t('.errorSendingPin')
  end

  def verify_phone_number
    if !params[:user][:pin].blank?
      current_user.verify_pin(params[:user][:pin])
      if current_user.phone_verified
        flash[:notice] = t('.yourPhoneNumberIsVerified')
      else
        flash[:alert] = t('.cannotVerifyYourPhoneNumber')
      end
    end
    redirect_to edit_user_registration_path
  rescue Exception => e
    logger.error e.inspect.to_s
    logger.error "Error verify pin: #{e.message}"
    redirect_to edit_user_registration_path, alert: t('.errorVerifingPin')
  end

  protected

  def avatar_user_params
    params.require(:user).permit(:avatar)
  end

  def user_params
    params.require(:user).permit(:phone_number, :pin)
  end
end
