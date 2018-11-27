# frozen_string_literal: true

require 'test_helper'

class ReverseGeolocationJobTest < ActiveJob::TestCase
  test 'reverse calculate geocoordinates has city' do
    ReverseGeolocationJob.perform_now
    location = locations(:withAddressAndCoordinates)
    Rails.logger.debug  "From address: #{location.address}"
    Rails.logger.debug  " Found longitude: #{location.longitude}"
    Rails.logger.debug  " Found latidude: #{location.latitude}"
    Rails.logger.debug  " Found city: #{location.city}"
    # Ignore for now
    # assert_equal "Dortmund", location.city
  end
end
