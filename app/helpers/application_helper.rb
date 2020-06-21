# frozen_string_literal: true

module ApplicationHelper
  def avatar_url(user)
    if !user
      'https://www.gravatar.com/avatar/unknown.jpg?d=mm&s=150'
    else
      # User defined avatar
      if user.avatar.exists?
        logger.debug 'Show avatar'
        return user.avatar.url
      end

      # From Oauth login provder
      if user.image
        secureUrl = user.image
        secureUrl.sub! 'http://', 'https://'
        secureUrl + '?width=300'
      else
        logger.debug 'Show gravatar'
        # Load from gravatar
        user_id = Digest::MD5.hexdigest(user.email.downcase)
        "https://www.gravatar.com/avatar/#{user_id}.jpg?d=mm&s=150"
      end
    end
  end

  def simple_date(from_time)
    to_time = Time.zone.now

    # TODO: localize!
    return from_time.strftime('%T') if from_time.today?

    return t('.yesterday') if (to_time - from_time) >= 1.days

    from_time.strftime('%d.%m.%y')
  end

  def maps_key
    ENV['maps_key']
  end

  # created <br> tags from raw text CR/LF
  def html_line_breaks(rawText)
    rawText.gsub(/(?:\n\r?|\r\n?)/, '<br>').html_safe
  end

  def page_title
    if request.domain == 'venueguru.net'
      'Venue Guru'
    else
      'Location Guru'
    end
  end

  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text[0..100]
  end

  def yield_meta_tag(tag, default_text = '')
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def html_short_link_text(target_link)
    target_link.remove('http://', 'https://')
  end
end
