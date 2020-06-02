
# Sets custom UI language
class LanguageController < ApplicationController

  # Sets new custom lnguage from paramers[:lnguage], fallbacks to de if not supporte
  def language
    language = params[:language]
    logger.debug "Custom language request to '#{language}'"
    language = 'de' unless %w[de en].include?(language)
    unless current_user.blank?
      current_user.language_id = language
      current_user.save
    end
    cookies[:custom_language] = language
    activate_locale
    redirect_to params[:redirect_to]
  end
end
