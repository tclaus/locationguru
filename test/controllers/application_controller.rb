require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

  test 'new user session -without temp location cookie-' do
    post user_session_url params: {user:
      {email: 'host@locationguru.net', password: '12345678'}
    }
    assert_redirected_to dashboard_url

  end

  test 'new user session and restore temporary location' do

    location = Location.create
    location.user = User.system_user
    location.listing_name = 'a'
    location.kind_type = 1
    location.location_type = 1
    location.max_persons = 42
    location.save

    guid = location.guid
    cookies[:temporary_location_guid] = guid

    post user_session_url params: {user:
      {email: 'host@locationguru.net', password: '12345678'}
    }
    assert_redirected_to listing_location_path(location)

  end

end
