require 'test_helper'
class StaticPagesControllerTest < ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers

  test "should get login" do
    get "/login"
    assert_response :success
  end

  test "should get new password" do
    get "/password/new"
    assert_response :success
  end

  test "should get confirmation" do
    get "/confirmation"
    assert_response :success
  end

  test "should get profile" do
      sign_in users(:host)
    get "/profile"
    assert_response :success
  end

  test "should get registration" do
    get "/registration"
    assert_response :success
  end

end
