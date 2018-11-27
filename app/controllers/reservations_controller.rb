# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: %i[accept destroy show_all]

  def create
    # Only here, if user is logged in. Date is requeted
    location = Location.find(params[:location_id])
    if current_user == location.user
      flash[:alert] = t('you_cannot_book_you_own_property')
      redirect_back(fallback_location: request.referer)
    else
      # Only logged - in user can start a reservation
      date_str = reservation_params[:start_date]
      date = Date.parse(date_str).strftime('%F')

      logger.debug('Redirect to create message')
      redirect_to send_message_location_path(location, date: date)
    end
  end

  def show
    # Show only reservation for ONE Location
  end

  def show_all
    @locations = current_user.locations
    logger.debug('Show reservations')
    @reservations = current_user.reservations.all.order(:start_date)
    render 'show'
  end

  def accept
    reservation = Reservation.find(params[:id])
    if !reservation.blank?
      if check_reservation_owner(reservation)
        reservation.set_status_booked
      else
        flash[:warning] = 'You are not allowed to accept this reservation'
      end
    else
      flash[:warning] = 'Reservation not found'
    end
    redirect_to reservations_show_all_path
  end

  def reject
    reservation = Reservation.find(params[:id])
    if !reservation.blank?
      if check_reservation_owner(reservation)
        reservation.set_status_inquery
      else
        flash[:warning] = 'You are not allowed to reject this reservation'
      end
    else
      flash[:warning] = 'Reservation not found'
    end
    redirect_to reservations_show_all_path
  end

  def destroy
    logger.debug "Delete reservation #{params.inspect}"
    reservation = Reservation.find(params[:id])
    if !reservation.blank?
      if check_reservation_owner(reservation)
        reservation.destroy
      else
        flash[:warning] = 'You are not allowed to delete this reservation'
      end
    else
      flash[:warning] = 'Reservation not found'
    end
    redirect_to reservations_show_all_path
  end

  private

  def check_reservation_owner(reservation)
    (reservation.location.user.id == current_user.id)
  end

  def reservation_params
    params.require(:reservation).permit(:start_date)
  end
end
