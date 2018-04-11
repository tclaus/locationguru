class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_filter :set_csp



  protected

  def set_csp
    response.headers['Content-Security-Policy'] = "default-src *;
    image-src https://s3.eu-central-1.amazonaws.com/eventlocation-photos"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[fullname phone_number description])
  end

  # Redirect after login
  def after_sign_in_path_for(_resource_or_scope)
    dashboard_path
  end

  private

  # sets the localizaton from request Header
  def set_locale
    I18n.locale = get_valid_language
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  # Returns a valid language ID. Fall back to a default
  def get_valid_language
    locale = extract_locale_from_accept_language_header
    logger.debug "* Extracted Locale ID: #{locale}"
    if !locale.blank? &&
      (locale == "de" ||
        locale == "en")
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
