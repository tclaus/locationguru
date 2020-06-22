# frozen_string_literal: true

require 'test_helper'

class CounterTest < ActiveSupport::TestCase
  test 'Increment visits per location' do
    location = Location.first
    weekly_calls = Counter.load_7days_location_visits(location.id)
    assert_same 0, weekly_calls

    Counter.increase_location_visit(location.id, '1.1.1.1')
    weekly_calls = Counter.load_7days_location_visits(location.id)
    assert_same 1, weekly_calls
   end

   test 'dont increment on same request ip' do
    location = Location.first
     Counter.increase_location_visit(location.id, '1.1.1.1')
     Counter.increase_location_visit(location.id, '1.1.1.1')
     Counter.increase_location_visit(location.id, '2.2.2.2')
     Counter.increase_location_visit(location.id, '2.2.2.2')
     weekly_calls = Counter.load_7days_location_visits(location.id)
     assert_same 2, weekly_calls
    end

end
