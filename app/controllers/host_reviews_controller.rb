class HostReviewsController < ApplicationController

def create
  # Check if the reservation exist (location_id, guest_id)
  # Check if current host already reviews the guest (only once)

  @reservation = Reservation.where(id: host_review_params[:reservation_id],
                          location_id: host_review_params[:location_id],
                          user_id: host_review_params[:guest_id]
                        ).first
  if !@reservation.nil?
    @has_reviewed = HostReview.where(
                      reservation_id: @reservation.id,
                      guest_id: host_review_params[:guest_id]
                      ).first
   if !@has_reviewed.nil?
     @host_review = current_user.host_reviews.create(host_review_params)
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
  @host_review = Review.find(params[:id])
  @host_review.destroy
  redirect_back(fallback_location, request.referer, notice: t('.removed_review'))

end

private
  def host_review_params
    params.require(:host_review).permit(:comment, :star, :location_id, :reservation_id, :guest_id)
  end
end
