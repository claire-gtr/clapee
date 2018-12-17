class ChangeDigitickIdTypeFromEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :digitick_id, :string
  end
end
