class AddPriceToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :digitick_date, :datetime
    add_column :events, :min_price, :string
  end
end
