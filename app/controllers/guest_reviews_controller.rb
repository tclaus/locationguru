class GuestReviewsController < ApplicationController

def create
  # Check if the reservation exist (location_id, host_id)
  # Check if current host already reviews the guest (only once)

  @reservation = Reservation.where(id: guest_review_params[:reservation_id],
                          location_id: guest_review_params[:location_id]
                        ).first
  if !@reservation.nil? && @reservation.location.user_id == guest_review_params[:host_id].to_i
    @has_reviewed = GuestReview.where(
                      reservation_id: @reservation.id,
                      host_id: guest_review_params[:host_id]
                      ).first
   if !@has_reviewed.nil?
     @guest_review = current_user.guest_reviews.create(guest_review_params)
     flash[:success] = t('.review_created')
   else
     flash[:success] = t('.you_already_reviewed_this_reservation')
   end

  else
    flash[:alert] = t('.not_found_this_reservation')
  end

  redirect_back(fallback_location: request.referer)
end

def destroy
  @guest_review = Review.find(params[:id])
  @guest_review.destroy
  redirect_back(fallback_location, request.referer, notice: t('.removed_review'))

end

private
  def guest_review_params
    params.require(:guest_review).permit(:comment, :star, :location_id, :reservation_id, :host_id)
  end
end
