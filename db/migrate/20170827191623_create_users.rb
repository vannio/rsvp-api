class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.references :address, foreign_key: true
      t.integer :party_size, default: 1

      t.timestamps
    end
  end
end
