# frozen_string_literal: true

require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test 'location has a guid' do
    location = Location.create
    location.user = User.system_user
    location.listing_name = 'a'
    location.kind_type = 1
    location.location_type = 1
    location.max_persons = 42
    location.save
    assert_not_nil location.guid
  end
end
