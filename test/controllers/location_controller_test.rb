require 'test_helper'

class LocationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get location_index_url
    assert_response :success
  end

  test "should get new" do
    get location_new_url
    assert_response :success
  end

  test "should get create" do
    get location_create_url
    assert_response :success
  end

  test "should get listing" do
    get location_listing_url
    assert_response :success
  end

  test "should get pricing" do
    get location_pricing_url
    assert_response :success
  end

  test "should get description" do
    get location_description_url
    assert_response :success
  end

  test "should get photo" do
    get location_photo_url
    assert_response :success
  end

  test "should get upload" do
    get location_upload_url
    assert_response :success
  end

  test "should get amenities" do
    get location_amenities_url
    assert_response :success
  end

end
