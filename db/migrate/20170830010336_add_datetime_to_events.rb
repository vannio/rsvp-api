class AddDatetimeToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :datetime, :timestamp
    remove_column :events, :date, :date
    remove_column :events, :time, :time
  end
end
