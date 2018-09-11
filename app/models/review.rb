class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :likes
  validates :stars, presence: true
end
