class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :phone_number, :description])
  end

  # Redirect after login 
  def after_sign_in_path_for(resource_or_scope)
    dashboard_path
  end

   private

   def set_locale
     logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
     I18n.locale = extract_locale_from_accept_language_header
     logger.debug "* Locale set to '#{I18n.locale}'"
   end

   def extract_locale_from_accept_language_header
     accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
     if accept_language
       accept_language.scan(/^[a-z]{2}/).first
     end

     DEFAULT_LANGUAGE
  end
end
