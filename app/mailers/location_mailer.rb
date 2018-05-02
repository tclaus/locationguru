class LocationMailer < ApplicationMailer

  # Send to location owner
  def location_mail
    @location = params[:location]
    @message = params[:message]

    email_with_name = "LocationGuru.net <#{@location.user.email}>"

    mail(to: email_with_name,
      from: "#{@message.name} (Location Guru) <no-reply@locationguru.net>",
      reply_to: @message.email,
      subject: t('.subject', location_name: @location.listing_name))
  end

  # reference amil to sender
  def location_mail_to_sender
    @location = params[:location]
    @message = params[:message]

    email_with_name = "#{@message.name} (Location Guru) <#{@message.email}>"

    mail(to: email_with_name,
      subject: t('.subject',location_name: @location.listing_name))
  end

end
