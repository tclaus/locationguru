# frozen_string_literal: true

# base class for generating jobs
class ApplicationJob < ActiveJob::Base
  def localize(location)
    I18n.locale = if !location.user.blank?
                    location.user.language_id
                  else
                    'en'
                  end
  end
end
