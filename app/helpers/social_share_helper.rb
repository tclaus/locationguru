module SocialShareHelper

  # Remove onClick handler for social sharing buttons
  def remove_onClick_eventhandler(htmlString)
    raw htmlString.gsub('onclick="return SocialShareButton.share(this);"','')
  end

end
