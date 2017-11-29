class Location < ApplicationRecord
  belongs_to :user
  has_many :room_property
  validates :building_type, presence: true
  validates :room_type, presence: true
  #validates :listing_name, presence: true
end
