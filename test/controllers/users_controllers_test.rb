# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should show user' do
    sign_in users(:host)
    get '/users/2'
    assert_response :success
  end

  test 'should be admin' do
    adminUser = users(:admin)
    assert adminUser.isAdmin
  end
end
