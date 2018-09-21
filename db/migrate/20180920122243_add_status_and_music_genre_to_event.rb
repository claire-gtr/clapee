class AddStatusAndMusicGenreToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :music_genre, :string
  end
end
