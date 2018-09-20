class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :likes, dependent: :destroy
  validates :stars, presence: true

  def stars_valid?
    errors.add(:name, "Vous devez choisir un nombre d'étoile pour publier votre avis")
  end
end
