class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.date :date
      t.time :time
      t.references :venue, foreign_key: true

      t.timestamps
    end
  end
end
