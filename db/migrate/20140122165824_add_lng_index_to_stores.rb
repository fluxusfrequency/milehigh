class AddLngIndexToStores < ActiveRecord::Migration
  def change
    add_index :stores, :lng
  end
end
