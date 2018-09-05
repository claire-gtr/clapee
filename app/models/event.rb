class Event < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
