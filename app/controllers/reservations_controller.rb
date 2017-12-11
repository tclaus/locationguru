class ReservationsController < ApplicationController

before_action :authenticate_user!
 # TODO: Wie ein Buchungs - System machen?
 # TODO: Überhaupt buchen??
 
  def create
    location = Location.find(params[:location_id])
    if current_user == location.user
      flash[:alert] = "You cannot book you own property"
    else
      start_date = Date.parse(reservation_params[:start_date])
      end_date = Date.parse(reservation_params[:end_date])
      days = (end_date - start_date) + 1
      @reservation = current_user.reservations.build(reservation_params)
      @reservation.location = location
      @reservation.total = 42 * days
      @reservation.save

      flash[:notice] = "Booked Successfully"
      redirect_to location
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date,
                                        :end_date)

  end
end
