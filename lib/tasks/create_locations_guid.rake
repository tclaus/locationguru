# frozen_string_literal: true

namespace :locationguru do
  desc 'Create guids for location that not already have one'
  task create_location_guids: :environment do
    no_guids = Location.where(guid: nil)
    no_guids.each do |location|
      if location.guid.nil?
        location.generate_unique_guid
        location.save(touch: false)
      end
    end
    puts "Created #{no_guids.count} tokens for locations"
  end
end
