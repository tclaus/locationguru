# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/send_not_activated_mail_mailer
class NotActivatedMailMailerPreview < ActionMailer::Preview
  def firstActivationMail
    NotActivatedMailMailer.with(location: Location.first).first_activation_reminder
  end

  def secondActivationMail
    NotActivatedMailMailer.with(location: Location.first).second_activation_reminder
  end

  def lastActivationMail
    NotActivatedMailMailer.with(location: Location.first).last_activation_reminder
  end
end
