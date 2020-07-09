# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :location
  belongs_to :reservation
  validates :location, presence: true

  validates :star, numericality: { less_than_or_equal_to: 5, greater_than: 0 }
  validates :comment, length: { maximum: 200 }
end
