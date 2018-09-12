class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.integer :zipcode
      t.string :town
      t.integer :location_digitick_id

      t.timestamps
    end
  end
end
