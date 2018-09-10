class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :likes
  validates :content, presence: true, length: { minimum: 20 }
end
