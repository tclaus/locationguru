# frozen_string_literal: true

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get '/'
    assert_response :success
  end

  test 'should get search' do
    get '/search'
    assert_response :success
  end
end
