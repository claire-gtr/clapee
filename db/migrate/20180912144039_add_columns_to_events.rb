class AddColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :digitick_url, :string
    add_reference :events, :location, index: true
  end
end
