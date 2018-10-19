class Location < ApplicationRecord
  has_many :events

  geocoded_by :address, latitude: :location_latitude, longitude: :location_longitude
end
