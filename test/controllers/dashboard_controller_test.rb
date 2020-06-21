# frozen_string_literal: true

require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should not get dashboard if not signed in' do
    get '/dashboard'
    assert_response :redirect
  end

  test 'should get dashboard signed in' do
    sign_in users(:host)
    get '/dashboard'
    assert_response :success
  end

  test 'should not get a admin-link for non admins' do
    # Should not have 'administrator' access
    get '/dashboard'
    assert_select 'li#admin-link', false
  end

  test 'should get a admin-link for admins' do
    sign_in users(:admin)
    get '/dashboard'
    assert_select 'li#admin-link'
  end
end
