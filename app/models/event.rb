class Event < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :location

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
