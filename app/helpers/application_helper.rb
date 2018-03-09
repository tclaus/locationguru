module ApplicationHelper
  def avatar_url(user)

    return user.avatar.url

    if user.image
      user.image
    else
      # Load from gravatar
      user_id = Digest::MD5.hexdigest(user.email.downcase)
      "https://www.gravatar.com/avatar/#{user_id}.jpg?d=mm&s=150"
    end
  end

def maps_key
   ENV['maps_key']
end

end
