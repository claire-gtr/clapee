class AddDigitickIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :digitick_id, :integer
  end
end
