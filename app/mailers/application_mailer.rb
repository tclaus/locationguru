# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Location Guru <no-reply@locationguru.net>'
  layout 'mailer'
  add_template_helper(ApplicationHelper)

end
