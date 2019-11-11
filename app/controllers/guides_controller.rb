# frozen_string_literal: true

##
# Controls the predefined searches
class GuidesController < ApplicationController

  def partyvenues
    # Load locations marked as 'party venues'
    @locations = Location.where(active: true, kind_type: 1)
    @simple_locations = create_simple_locations(@locations)
    render 'clubhouse'
  end

  def multi_purpose_rooms
    # Load locations marked as 'pMehrzweckraum'
    @locations = Location.where(active: true, kind_type: 6)
    @simple_locations = create_simple_locations(@locations)
    render 'clubhouse'
  end

  def clubhouses
    # Load locations marked as 'KGV / Clubhouse'
    @locations = Location.where(active: true, kind_type: 12)
    @simple_locations = create_simple_locations(@locations)
    render 'clubhouse'
  end

  def pubs
    # Load locations marked as 'bar'
    @locations = Location.where(active: true, kind_type: 4)
    @simple_locations = create_simple_locations(@locations)
    render 'clubhouse'
  end

  def restaurants
    # Load locations marked as 'restaurant'
    @locations = Location.where(active: true, kind_type: 3)
    @simple_locations = create_simple_locations(@locations)
    render 'clubhouse'
  end
end
