require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'do not show admin statistics for non admins' do
    get admin_url
    assert_response :redirect
  end

  test 'load admin statistics' do
    sign_in users(:admin)
    get admin_url
    assert_response :success
  end
end
