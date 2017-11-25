module ApplicationHelper
  def avatar_url(user)
    user_id = Digest::MD5.hexdigest(user.email.downcase)
    if user.image
    user.image #  "https://graph.facebook.com/#{user.id}/picture?type=large"
    else
      "https://www.gravatar.com/avatar/#{user_id}.jpg?d=identical&s=150"
    end
  end
end
