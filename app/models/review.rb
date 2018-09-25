class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :likes, dependent: :destroy
  validates :stars, :presence => {:message => "Stars can't be blank." }
  validates :content, presence: true

end
