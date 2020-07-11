# frozen_string_literal: true

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def setup
    @review = Review.create(location_id: 1, reservation_id: 1)
  end

  test 'Review validates' do
    @review.star = 1
    @review.comment = 'this is a cool comment'
    assert @review.validate!
  end

  test 'Review star <= 5' do
    @review.star = 6
    assert_not @review.validate!
  end
end
