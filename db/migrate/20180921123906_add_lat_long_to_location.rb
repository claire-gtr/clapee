class AddLatLongToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :location_latitude, :string
    add_column :locations, :location_longitude, :string
  end
end
