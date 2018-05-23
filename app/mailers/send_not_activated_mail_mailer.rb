class SendNotActivatedMailMailer < ApplicationMailer
  default from: 'Thorsten Claus <thorsten.claus@locationguru.net>'

  def first_activation_reminder
    @location = params[:location]
    @edit_url = listing_location_url(@location)
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    delivery_options = {'o:tag': 'Activation Reminder'}
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name),
       delivery_method_options: delivery_options)
  end

  def second_activation_reminder
    @location = params[:location]
    @edit_url = listing_location_url(@location)
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    delivery_options = {'o:tag': 'Activation Reminder'}
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name),
       delivery_method_options: delivery_options)
  end

  def last_activation_reminder
    @location = params[:location]
    @edit_url = listing_location_url(@location)
    email_with_name = "LocationGuru.net <#{@location.user.email}>"
    delivery_options = {'o:tag': 'Activation Reminder'}
    mail(to: email_with_name,
         subject: t('.subject', location_name: @location.listing_name),
       delivery_method_options: delivery_options)
  end
end
