class AddStoreIdIndexToReviews < ActiveRecord::Migration
  def change
    add_index :reviews, :store_id
  end
end
