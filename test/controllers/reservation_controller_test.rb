# frozen_string_literal: true

require 'test_helper'

class ResevationControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'Test show the reservations view' do
    sign_in users(:host)
    get reservations_show_all_path
    assert :success
  end
  # Add test for a real reservation and a inquery
end
