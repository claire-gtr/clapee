class ChangeCoordinatesTypeFromLocation < ActiveRecord::Migration[5.2]
  def change
    change_column :locations, :location_latitude, "float USING CAST(location_latitude AS float)"
    change_column :locations, :location_longitude, "float USING CAST(location_latitude AS float)"
  end
end
