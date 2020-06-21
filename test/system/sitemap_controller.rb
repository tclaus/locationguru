require "application_system_test_case"

class PagesControllerTest < ApplicationSystemTestCase
  test 'Get a sitemap' do
    location = Location.new
    location.kind_type = 2
    location.listing_name = 'On a sitemap"'
    location.summary = "Content"
    location.active = :true
    location.user_id = 1
    location.city =  'Dortmund'
    location.save

    visit "sitemap.xml"
    expect(page).to have_content "my post"
  end
end
