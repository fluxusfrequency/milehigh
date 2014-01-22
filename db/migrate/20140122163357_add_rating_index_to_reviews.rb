class AddRatingIndexToReviews < ActiveRecord::Migration
  def change
    add_index :reviews, :rating
  end
end
