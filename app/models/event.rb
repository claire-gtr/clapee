class Event < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :location

  include PgSearch

  pg_search_scope :search, :against => [:title, :description, :artist_name, :music_genre],
                  :associated_against => {
                    :location => [:name, :address, :zipcode, :town],
                  }
                  # :ignoring => :accents
                  # ,
                  # :using => :trigram

  scope :future, -> { where("digitick_date > ?", Time.current).order(digitick_date: :asc) }
  scope :with_at_least_reviews, ->(count) { joins(:reviews).group('events.id').having('count(event_id) >= ?', count) }
  scope :average_reviews_above, ->(stars) { joins(:reviews).group('events.id').having('AVG(stars) >= ?', stars) }

  def self.future
    where("digitick_date > ?", Time.current).order(digitick_date: :asc)
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def is_for_sale
    return status unless ["0", "1"].include? status
    status == "1" ? "Vente en cours" : "Vente terminée"
  end
end
