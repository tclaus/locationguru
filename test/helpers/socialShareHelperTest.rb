
class SocialShareHelperTest < ActionView::TestCase

  test 'should remove onClickHandler in social share buttons' do
    rawData = remove_onClick_eventhandler('onclick="return SocialShareButton.share(this);"')
    assert_equal rawData,''
  end
end
