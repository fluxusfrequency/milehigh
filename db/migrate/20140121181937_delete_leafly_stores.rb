class DeleteLeaflyStores < ActiveRecord::Migration
  def change
    drop_table :leafly_stores
  end
end
