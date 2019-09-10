require 'test_helper'

class DeleteNotActivatedAccountsJobTest < ActiveJob::TestCase

  test 'that old unconfirmed accounts will be deleted' do

    # Create unconfirmed mail
    now = Date.today
    time_ago = (now - 100)
    user = User.create(email: 'spam@example.com', password: '123-test')
    user.created_at = time_ago
    assert user.save!
    DeleteNotActivatedAccountsJob.perform_now
    assert_no_match User.last.email,'spam@example.com'
 end
end
