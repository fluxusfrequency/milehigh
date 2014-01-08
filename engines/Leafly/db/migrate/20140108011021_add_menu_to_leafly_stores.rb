class AddMenuToLeaflyStores < ActiveRecord::Migration
  def change
    add_column :leafly_stores, :menu, :text
  end
end
