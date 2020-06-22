# Preview all emails at http://localhost:3000/rails/mailers/send_insufficient_photos_mailer
class InsufficientPhotosMailerPreview < ActionMailer::Preview
  def insufficient_photos_mailer
    InsufficientPhotosMailer.with(location: Location.first).send_mail
  end
end
