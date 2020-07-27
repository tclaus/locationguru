# frozen_string_literal: true

require 'test_helper'

class LocationControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Admin - Site later
  #  test 'should get index' do
  #    get '/admin'
  #    assert_response :success
  #  end
  test 'should redirect locations if not logged in' do
    get '/locations'
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test 'should show error on missing kind_type on create a location' do
    sign_in users(:host)

    post locations_path, params: {
      location: {
        listing_name: 'test-name'
      }
    }

    assert_redirected_to(new_location_url({ listing_name: 'test-name' }))
    assert_not_nil(flash[:alert])
  end

  test 'should attach new location to sign in user' do
    sign_in users(:host)
    get new_location_url
    assert_response :success # 302
  end

  test 'should create a location' do
    sign_in users(:host)

    post locations_url, params: {
      location: {
        listing_name: 'test-name',
        kind_type: 1,
        location_type: 1,
        max_persons: 42
      }
    }

    assert_response :found # 302
    assert_nil(flash[:alert])
  end

  test 'should update a location' do
    sign_in users(:host)
    location = locations(:one)
    location.listing_name = 'Updated by test'
    put location_url(location), params: {
      location: {
          listing_name: 'Updated by test'
      }
    }
    assert_response :redirect
    location.reload
    assert_equal location.listing_name, 'Updated by test'
  end

  test 'should send a mail if activation status changes' do
    sign_in users(:host)
    location = locations(:one)
    put location_url(location), params: {
      location: {
          active: false
      }
    }
    # Should send a mail
  end

  test 'should delete a location' do
    sign_in users(:host)
    location = locations(:one)
    delete location_url(location)
    assert :success
    assert_not Location.exists?(location.id)
    assert_not Message.exists?(location_id: location.id)
    assert_not Review.exists?(location_id: location.id)
    assert_not Reservation.exists?(location_id: location.id)
    assert_not Photo.exists?(location_id: location.id)
  end

  test 'should get specific location' do
    get '/locations/1'
    assert_response :success
  end

  test 'should not return a inactive location' do
    sign_in users(:host)
    get '/locations/' + locations(:inactive).id.to_s
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test 'should get new' do
    sign_in users(:host)
    get '/locations/new'
    assert_response :success
  end

  test 'should get listing' do
    sign_in users(:host)
    get '/locations/1/listing'
    assert_response :success
  end

  test 'should get amenities' do
    sign_in users(:host)
    get '/locations/1/amenities'
    assert_response :success
  end

  test 'should get description' do
    sign_in users(:host)
    get '/locations/1/description'
    assert_response :success
  end

  test 'should get suitable for' do
    sign_in users(:host)
    get '/locations/1/suitables'
    assert_response :success
  end

  test 'should get upload photo' do
    sign_in users(:host)
    get '/locations/1/photo_upload'
    assert_response :success
  end

  test 'should get location' do
    sign_in users(:host)
    get '/locations/1/location'
    assert_response :success
  end
end
