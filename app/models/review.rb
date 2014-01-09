class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :store, class_name: Leafly::Store

  validates :user_id, :store_id, :body, :title, presence: true
  validates_inclusion_of :rating, :in => ['thumbs up', 'thumbs down']
end
