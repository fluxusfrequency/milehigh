class AddLatIndexToStores < ActiveRecord::Migration
  def change
    add_index :stores, :lat
  end
end
