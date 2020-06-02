require 'test_helper'

class LanguageControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  test "should fallback to default if invalid language requested " do
    get language_path('qq', redirect_to: '')
    assert_response :redirect
    assert_equal I18n.locale, :de
  end

  test "should set custom en language" do
    get language_path('en', redirect_to: '')
    assert_response :redirect
    assert_equal I18n.locale, :en
  end
end
