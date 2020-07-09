# frozen_string_literal: true

# Reviews for existing reservations
class LocationReviewsController < ApplicationController
  def new
    token = params[:review_token]
    logger.debug " New review for review token: #{token}"
    @reservation = Reservation.find_by(review_token: token)
    if !@reservation.nil?
      if !Review.exists?(reservation_id: @reservation.id)
        @review = @reservation.build_review(location_id: @reservation.location_id)
        render 'reviews/_review_form'
      else
        # Maybe show the review
        logger.info " A review for this token was already set #{token}"
        flash[:alert] = t('.a_review_already_exists')
        redirect_to(location_path(@reservation.location)) && return
      end
    else
      logger.info " Invalid review token #{token}"
      flash[:alert] = t('.invalid_reservation_token')
      redirect_to(root_path) && return
    end
  end

  def create
    # Check if the reservation exist (location_id, reservation_id)
    # Check if current host already reviews the guest (only once)
    # Need a token to create a review
    # Tokens are generated for each reservation
    @reservation = Reservation.find_by(review_token: review_params[:review_token])
    if !@reservation.nil?

      if @reservation.review.nil?
        review = Review.create(
          reservation_id: @reservation.id,
          location_id: @reservation.location_id,
          comment: review_params[:comment],
          star: review_params[:star],
          name: review_params[:name]
        )
        if !review.nil?
          logger.info("New review created for location with id: #{@reservation.location_id}")
          flash[:success] = t('.review_created')
          redirect_to(location_path(@reservation.location)) && return
        else
          redirect_back(fallback_location, request.referer, notice: t('.error_on_saving'))
        end
      else
        flash[:alert] = t('.you_already_reviewed_this_reservation')
      end
    else
      logger.warn('A post for a new review received but the token was invalid.')
      flash[:alert] = t('.not_found_this_reservation')
    end

    redirect_to(root_path) && return
  end

  def destroy
    @host_review = Review.find(params[:id])
    @host_review.destroy
    redirect_back(fallback_location, request.referer, notice: t('.removed_review'))
  end

  private

  def review_params
    params.require(:review).permit(:comment, :star, :name, :location_id, :reservation_id, :review_token)
  end
end
