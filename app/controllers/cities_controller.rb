# frozen_string_literal: true

##
# Cities
class CitiesController < ApplicationController
  def show
    # Params holds a city
    # If empty - fall back to all
    # else show locations in this city

    redirect_to '/search?utf8=✓&search=' + params[:id]
  end
end
