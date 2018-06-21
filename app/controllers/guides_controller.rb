class GuidesController < ApplicationController

  def kgv
    # Load locations marked as 'KGV / Clubhouse'
    @locations = Location.where(active: true, kind_type: 12)
    @simpleLocations = createSimpleLocations(@locations)
  end
end
