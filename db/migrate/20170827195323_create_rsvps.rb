class CreateRsvps < ActiveRecord::Migration[5.1]
  def change
    create_table :rsvps do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :adults
      t.integer :children
      t.text :comments

      t.timestamps
    end
  end
end
