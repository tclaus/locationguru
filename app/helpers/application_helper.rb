module ApplicationHelper
  def avatar_url(user)
    user_id = Digest::MD5::hexdigest(user.email.downcase)

    "https://www.gravatar.com/avatar/#{user_id}.jpg?d=identical&s=150"
  end
end
