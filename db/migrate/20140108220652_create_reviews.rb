class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :store
      t.string :rating
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
