class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :slug
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :hours
      t.string :website
      t.string :phone_number
      t.text :menu

      t.timestamps
    end
  end
end
