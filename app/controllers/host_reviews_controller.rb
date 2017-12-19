class HostReviewsController < ApplicationController

private
  def host_reviwe_params
    params.require[:host_review].permit(:comment, :star, :location_id, :reservation_is, :guest_id)
  end
end
