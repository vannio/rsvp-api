class CreateVenues < ActiveRecord::Migration[5.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.text :url
      t.text :description
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
