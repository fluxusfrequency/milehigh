class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :store, class_name: Leafly::Store

  validates :store_id, :body, :title, presence: true
  validates_inclusion_of :rating, :in => ['Thumbs Up', 'Thumbs Down']

  def self.most_recent(number)
    all.order(created_at: :desc).limit(number)
  end
end
