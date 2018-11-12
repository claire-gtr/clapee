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

  def self.future
    where("digitick_date > ?", Time.current).order(digitick_date: :asc)
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
