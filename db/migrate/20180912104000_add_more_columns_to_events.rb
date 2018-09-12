class AddMoreColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :artist_name, :string
    add_column :events, :status, :string
    add_column :events, :location_id, :integer
    add_column :events, :location_address,:string
    add_column :events, :location_zipcode, :integer
    add_column :events, :event_picture_url, :string
  end
end
