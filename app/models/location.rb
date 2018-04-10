class Location < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :guest_reviews

  geocoded_by :address
  after_validation :geocode , if: :address_changed?

  validates :kind_type, presence: true
  validates :location_type, presence: true

  before_create :setInactive

  reverse_geocoded_by :latitude, :longitude do |obj,results|

    if geo = results.first
      obj.city    = geo.city
      obj.country = geo.country_code
    end
  end
  after_validation :reverse_geocode


  def cover_photo(size)
    if !photos.empty?
      photos[0].image.url(size)
    else
      if size == ':medium'
        'empty_thumb_medium.png'
      else
        'empty_thumb.png'
      end
    end
  end

  def has_amemities
    has_heating || has_kitchen || has_outdoor || has_music_eq ||
       has_furniture || has_parking_space || has_air_conditioning
  end

  def average_rating
    guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
  end

private
  def setInactive
    self.active = false
  end

end
