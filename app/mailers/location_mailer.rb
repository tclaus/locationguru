class LocationMailer < ApplicationMailer

  def location_mail
    @location = params[:location]
    @message = params[:message]

    email_with_name = "LocationGuru.net <#{@location.user.email}>"

    mail(to: email_with_name,
      from: "#{@message.name} (Locationguru) <no-reply@locationguru.net>",
      reply_to: @message.email,
      subject: "You got mail from locationGuru for #{@location.listing_name}")
  end
end
