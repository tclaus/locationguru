# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :activate_locale
  before_action :set_csp
  before_action :set_cities_link_cloud
  before_action :set_header_class

  protected

  # Creates location array with less fields
  def create_simple_locations(locations)
    simple_locations = []
    unless locations.blank?
      locations.each do |location|
        next unless location.geocoded?

        simple_locations.push create_simple_location(location)
      end
    end
    simple_locations
  end

  # Load cities cloud
  def set_cities_link_cloud
    # Cache these a bit?
    @link_clouds = Location.activated
                           .select('city')
                           .group('city')
                           .order('city')
  end

  def set_csp
    # Set all restrictions for content security
    response.headers['Content-Security-Policy'] =
      "default-src 'none';" \
      "script-src 'self' 'sha256-1fGkNkXvtZDs1faIpI9QamIelCDJqvDPc6k/qVlHNLA=' cdn.headwayapp.co js.stripe.com www.googletagmanager.com google-analytics.com www.google-analytics.com maps.googleapis.com cdnjs.cloudflare.com;" \
      "img-src 'self' data: www.gravatar.com maps.googleapis.com www.google-analytics.com maps.gstatic.com platform-lookaside.fbsbx.com s3.eu-central-1.amazonaws.com www.myo-design.de;" \
      "style-src 'self' 'unsafe-inline' cdn.headwayapp.co/headway-animate.css *.googleapis.com cdnjs.cloudflare.com;" \
      "font-src  'self' fonts.gstatic.com;"\
      "child-src 'self' js.stripe.com;" \
      "connect-src 'self' api.stripe.com www.google-analytics.com;"\
      "frame-src 'self' js.stripe.com headway-widget.net;" \
      "form-action 'self';"\
      "base-uri 'self';"\
      "manifest-src 'self'"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys:
      %i[first_name last_name phone_number description language_id])
  end

  # Redirect after login
  def after_sign_in_path_for(_resource_or_scope)
    location = rescue_temporary_venue
    if !location.nil?
      listing_location_path(location)
    else
      dashboard_path
    end
  end

  # Detect if we are on a apple device
  def safari_browser?
    agent = request.headers['HTTP_USER_AGENT'].downcase
    agent.match('safari')
  end

  private

  # Any venue that has been created before login should be rescured and
  # assigned to singed_in user
  def rescue_temporary_venue
    temp_guid = cookies[:temporary_location_guid]
    unless temp_guid.nil?
      cookies[:temporary_location_guid] = nil
      logger.info(" Assign temporary location with guid #{temp_guid}to newly signed in user")
      location = Location.find_by(guid: temp_guid)
      if !location.nil? && location.user == User.system_user
        location.user = current_user
        location.save
        location
      end
    end
  end

  # Sets a random header slider class
  def set_header_class
    slider_classes = %w[header-slider-1
                        header-slider-2
                        header-slider-5
                        header-slider-6
                        header-slider-8
                        header-slider-9]

    @background_header_class = slider_classes.sample
  end

  def create_simple_location(location)
    simple_location =  SimpleLocation.new
    simple_location.id = location.id
    simple_location.listing_name = location.listing_name
    simple_location.latitude = location.latitude
    simple_location.longitude = location.longitude
    simple_location
  end

  # sets the localizaton logged-in user or from user record
  def activate_locale
    I18n.locale = valid_language
  end

  # Returns a valid language ID. Fall back to a default
  def valid_language
    locale = language_from_current_user || custom_language_from_cookie || language_from_header || 'de'
    logger.info "* Using locale ID: #{locale}"
    # Only de or en is a supported language
    locale = DEFAULT_LANGUAGE if locale != 'de' && locale != 'en'
    cookies[:custom_language] = locale
    locale
  end

  def language_from_current_user
    current_user.language_id unless current_user.blank?
  end

  def custom_language_from_cookie
    cookie_language = cookies[:custom_language]
    logger.debug "* Language from cookie: #{cookie_language}"
    cookie_language
  end

  # extracts the accept-language header
  def language_from_header
    accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
    logger.info "* Accept-Language from header: #{accept_language}"
    return accept_language.scan(/^[a-z]{2}/).first if accept_language
  end
end
