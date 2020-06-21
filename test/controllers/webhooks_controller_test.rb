require 'test_helper'

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "should get mails" do
    post webhooks_mails_url
    assert_response :success
  end
end
