require 'test_helper'

class UpdateLocatationCountJobTest < ActiveJob::TestCase
  test "update total locations count" do
    UpdateLocatationCountJob.perform_now
    year = Date.today.year
    week = Date.today.cweek
    assert(Counter.total_location_count_in(year, week - 1).zero?)
    assert(Counter.total_location_count_in(year, week).positive?)
  end

  test "update total active locations count" do
    UpdateLocatationCountJob.perform_now
    year = Date.today.year
    week = Date.today.cweek
    assert(Counter.total_active_location_count_in(year, week - 1).zero?)
    assert(Counter.total_active_location_count_in(year, week).positive?)
  end

  test "update total confirmed users count" do
    UpdateLocatationCountJob.perform_now
    year = Date.today.year
    week = Date.today.cweek
    assert(Counter.total_active_user_count_in(year, week - 1).zero?)
    
    total_active_user_count = User.where('confirmed_at IS NOT NULL').count
    assert(Counter.total_active_user_count_in(year, week) == total_active_user_count)
  end

end
