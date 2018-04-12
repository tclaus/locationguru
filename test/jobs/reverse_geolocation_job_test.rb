require 'test_helper'

class ReverseGeolocationJobTest < ActiveJob::TestCase
  test "reverse calculate geocoordinates has city" do
      ReverseGeolocationJob.perform_now
      location = locations(:withAddress)
      Rails.logger.debug  "From address: #{location.address}"
      Rails.logger.debug  " Found longitude: #{location.longitude}"
      Rails.logger.debug  " Found latidude: #{location.latitude}"
      Rails.logger.debug  " Found city: #{location.city}"
     assert_equal "Dortmund", location.city
   end
end
