require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should show user" do
    sign_in users(:host)
    get '/users/1'
    assert_response :success
  end

end
