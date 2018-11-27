# frozen_string_literal: true

require 'test_helper'

class PrivacyControllerTest < ActionDispatch::IntegrationTest
  test 'should get privacy page' do
    get '/privacy'
    assert :success
  end
end
