# frozen_string_literal: true

module CounterHelper
  # Load total numbers for each location
  def load_total_numbers(locations)
    locations.each do |location|
      location.total_count = load_total_number(location)
    end
  end

  # Returns total sum for location ID
  def load_total_number(location)
    # context : location, type: location_id
    count = Counter.where(context: 'location_visits_for_user', context_type: location.id).sum('count')
    count
  end
end
