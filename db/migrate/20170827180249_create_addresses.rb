class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :postcode
      t.string :country
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
