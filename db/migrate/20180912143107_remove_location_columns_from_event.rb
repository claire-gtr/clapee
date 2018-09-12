class RemoveLocationColumnsFromEvent < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :location_name
    remove_column :events, :location_id
    remove_column :events, :location_zipcode
    remove_column :events, :location_address
  end
end
