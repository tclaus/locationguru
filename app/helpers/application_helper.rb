module ApplicationHelper
  def avatar_url(user)

    # User defined avatar
    if user.avatar.exists?
      logger.debug "Show avatar"
      return user.avatar.url
    end

    # From Oauth login provder (facebook)
    if user.image
      logger.debug "Show facebook image"
      secureUrl = user.image
      secureUrl.sub! 'http://', 'https://'
      secureUrl + '?width=300'
    else
      logger.debug "Show gravatar"
      # Load from gravatar
      user_id = Digest::MD5.hexdigest(user.email.downcase)
      "https://www.gravatar.com/avatar/#{user_id}.jpg?d=mm&s=150"
    end
  end

  def maps_key
     ENV['maps_key']
  end

  def page_title
    if request.domain == "venueguru.net"
      return "Venue Guru"
    else
      return "Location Guru"
    end
  end

  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text='')
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

end
