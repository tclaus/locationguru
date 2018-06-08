class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
    # Only here, if user is logged in. Date is requeted
    location = Location.find(params[:location_id])
    if current_user == location.user
      flash[:alert] = t("you_cannot_book_you_own_property")
      redirect_back(fallback_location: request.referer)
    else
      # Only logged - in user can start a reservation
      date_str = reservation_params[:start_date]
      date =  Date.parse(date_str).strftime("%F")

      logger.debug("Redirect to create message")
      redirect_to send_message_location_path(location, date: date)
    end
  end

  def your_trips
    @trips = current_user.reservations.order(start_date: :asc)
  end

  def your_reservations
    @locations = current_user.locations
    logger.debug("Show reservations")
    @meetings = current_user.reservations.all
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date,
                                        :end_date)

  end
end
