class AddCoordinatesToStores < ActiveRecord::Migration
  def change
    add_column :stores, :lat, :string
    add_column :stores, :lng, :string
  end
end
