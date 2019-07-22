# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :guest_reviews, dependent: :destroy
  has_many :messages, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  after_validation :reverse_geocode

  validates :kind_type, presence: true
  validates :location_type, presence: true
  validates :listing_name, length: { maximum: 200 }
  validates :max_persons, numericality: { less_than: 100_000 }
  validates :suitableForText, length: { maximum: 50 }

  before_create :set_inactive

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if (geo = results.first)
      obj.city    = geo.city
      obj.country = geo.country_code
    end
  end

  attr_accessor :total_count

  def cover_photo(size)
    if !main_photo.nil?
      main_photo.image.url(size)
    elsif size == ':medium'
      'empty_thumb_medium.png'
    else
      'empty_thumb.png'
    end
  end

  def main_photo
    if !photos.empty?
      photos.each do |photo|
        return photo if photo.is_main
      end
      photos[0]
    end
  end

  def has_amemities
    has_heating || has_kitchen || has_outdoor || has_music_eq ||
      has_furniture || has_parking_space || has_air_conditioning
  end

  def has_suitables
    isForBusiness || isForClubbing || isForWeddings || isForPhotoFilm ||
      isForConferences || isForPrivateParties || isForBachelorParties || isForChristmasParties ||
      !suitableForText.blank?
  end

  def average_rating
    guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
  end

  def is_active?
    active
  end

  private

  def set_inactive
    self.active = false
  end
end
