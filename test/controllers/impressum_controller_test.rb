require 'test_helper'

class ImpressumControllerTest < ActionDispatch::IntegrationTest

  test "should get impressum page" do
      get '/impressum'
     assert :success
   end


end
