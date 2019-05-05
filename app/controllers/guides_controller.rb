# frozen_string_literal: true

##
# Controls the predefined searches
class GuidesController < ApplicationController
  def kgv
    # Load locations marked as 'KGV / Clubhouse'
    @locations = Location.where(active: true, kind_type: 12)
    @simple_locations = create_simple_locations(@locations)
  end
end
