# frozen_string_literal: true

module CounterHelper
  # Load total visit numbers for each location and add to each location
  def self.load_total_numbers(locations)
    locations.each do |location|
      location.total_count = load_total_visit_number(location)
    end
  end

  # Returns total visit sum for a location ID
  def self.load_total_visit_number(location)
    # context : location, type: location_id
    Counter.where(context: 'location_visits_for_user', context_type: location.id)
           .sum('count')
  end
end
