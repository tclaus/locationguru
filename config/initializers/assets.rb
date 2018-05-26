# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.1'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w(
navbar_geocomplete
home_geocomplete
average_rating
maps_single_location
search_filters
maps_location_list
photos_upload
profile_pic_upload
flash_messages
google_analytics
select_message
send_message_on_button
cards
location_restricted
cookie_banner/cookie_banner_de
cookie_banner/cookie_banner_en
)
