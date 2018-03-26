require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should not destroy photo if not authenticated" do
    #delete "/locations/1/photos/1"
    #assert_response :success
  end

  test "should destroy photo if authenticated" do
    #sign_in users(:host)
    #delete "/locations/1/photos/1"
    #assert_response :success
  end

end
