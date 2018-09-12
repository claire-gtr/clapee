class Event < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :location
end
