class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :store

  validates :store_id, :body, :title, :user_id, presence: true
  validates_inclusion_of :rating, :in => ['Thumbs Up', 'Thumbs Down']

  def self.most_recent(number)
    all.order(created_at: :desc).limit(number)
  end

  def thumbs_up?
    rating == "Thumbs Up"
  end

  def thumbs_down?
    rating == "Thumbs Down"
  end
end
