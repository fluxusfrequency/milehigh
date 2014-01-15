# This migration comes from leafly (originally 20140108011021)
class AddMenuToLeaflyStores < ActiveRecord::Migration
  def change
    add_column :leafly_stores, :menu, :text
  end
end
