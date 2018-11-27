# frozen_string_literal: true

Geocoder.configure(
  units: :km,
  api_key: ENV['maps_key']
)

Geocoder.configure(
  # caching (see below for details):
  # caching (see below for details):
  cache: :REDIS,
  cache_prefix: 'GeoCode_'
)
