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
      secureUrl = user.image.sub! 'http', 'https'
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

end
