require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get dashboard not signed in" do
    get "/dashboard"
    assert_response :redirect
  end

  test "should get dashboard signed in" do
    sign_in users(:host)
    get "/dashboard"
    assert_response :success
  end


end
