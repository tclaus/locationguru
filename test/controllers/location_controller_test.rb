require 'test_helper'

class LocationControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    get '/locations/1'
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
