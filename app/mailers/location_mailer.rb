class LocationMailer < ApplicationMailer
  # Send to location owner
  def location_mail
    @location = params[:location]
    @message = params[:message]

    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    I18n.locale = @location.user.language_id
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
         subject: t('.subject', location_name: @location.listing_name))
  end

  def location_activated
    @location = params[:location]
    @edit_url = listing_location_url(@location)
    @show_url = location_url(@location)
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    mail(to: email_with_name,
         from: 'Location Guru <no-reply@locationguru.net>',
         subject: t('.subject', location_name: @location.listing_name))
  end

  def location_deactivated
    @location = params[:location]
    @edit_url = listing_location_url(@location)
    @show_url = location_url(@location)

    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    mail(to: email_with_name,
         from: 'Location Guru <no-reply@locationguru.net>',
         subject: t('.subject', location_name: @location.listing_name))
  end
end
