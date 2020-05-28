# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_csp
  before_action :set_cities_link_cloud
  before_action :set_header_class

  protected

  # Needed to easyly access google maps
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
    @link_clouds = Location.where(active: true)
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
      "base-uri 'self'"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys:
      %i[first_name last_name phone_number description language_id])
  end

  # Redirect after login
  def after_sign_in_path_for(_resource_or_scope)
    dashboard_path
  end

  private

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

  # sets the localizaton from request Header
  def set_locale
    if current_user.blank?
      I18n.locale = valid_language
      logger.debug "* Locale set to '#{I18n.locale}'"
    else
      I18n.locale = current_user.language_id
    end
  end

  # Returns a valid language ID. Fall back to a default
  def valid_language
    locale = extract_locale_from_accept_language_header
    logger.debug "* Extracted Locale ID: #{locale}"
    if !locale.blank? &&
       (locale == 'de' ||
         locale == 'en')
      locale
    else
      DEFAULT_LANGUAGE
    end
  end

  # extracts the accept-language header
  def extract_locale_from_accept_language_header
    accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
    logger.debug "* Accept-Language from header: #{accept_language}"
    return accept_language.scan(/^[a-z]{2}/).first if accept_language
  end
end
