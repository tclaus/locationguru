class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
      logger.debug("Create reservation")
    location = Location.find(params[:location_id])
    if current_user == location.user
      flash[:alert] = t("you_cannot_book_you_own_property")
    else
      start_date = Date.parse(reservation_params[:start_date])
      end_date = Date.parse(reservation_params[:end_date])
      days = (end_date - start_date) + 1
      @reservation = current_user.reservations.build(reservation_params)
      @reservation.location = location
      @reservation.total = 42 * days
      @reservation.save

      flash[:notice] = t("booked_successfully")
      redirect_to location
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
