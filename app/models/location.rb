class Location < ApplicationRecord
  belongs_to :user
  has_many :photos

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :kind_type, presence: true
  validates :location_type, presence: true
  # validates :listing_name, presence: true

  def cover_photo(size)
    if !photos.empty?
      photos[0].image.url(size)
    else
      'empty_thumb.png'
    end
  end

end
