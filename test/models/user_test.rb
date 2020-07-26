# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'find system user' do
    system_user = User.find_system_user
    assert_not_nil system_user
  end

  test 'has system user (memorized)' do
    system_user = User.system_user
    assert_not_nil system_user
  end

  test 'system user has system flag' do
    user = User.system_user
    assert user.system_user?
  end
  test 'system user has id' do
    user = User.system_user
    assert_not_nil user.id
  end
end
