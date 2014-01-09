# This migration comes from leafly (originally 20140108005358)
class CreateLeaflyStores < ActiveRecord::Migration
  def change
    create_table :leafly_stores do |t|
      t.string :slug
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :hours
      t.string :website
      t.string :phone_number

      t.timestamps
    end
  end
end
