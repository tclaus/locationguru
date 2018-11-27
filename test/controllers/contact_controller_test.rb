# frozen_string_literal: true

require 'test_helper'

class ContactControllerTest < ActionDispatch::IntegrationTest
  test 'should get contactPage' do
    get '/contact'
    assert_response :success
  end
end
