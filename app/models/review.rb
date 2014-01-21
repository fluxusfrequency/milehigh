class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :store

  scope :positive, -> { where(rating: "Thumbs Up") }
  scope :negative, -> { where(rating: "Thumbs Down") }

  validates :store_id, :body, :title, :user_id, presence: true
  validates_inclusion_of :rating, :in => ['Thumbs Up', 'Thumbs Down']

  def self.most_recent(number, user)
    reviews = all.order(created_at: :desc)
    friend_reviews = user.friend_reviews
    (reviews - friend_reviews - user.reviews).take(number)
  end

  def thumbs_up?
    rating == "Thumbs Up"
  end

  def thumbs_down?
    rating == "Thumbs Down"
  end

  def store_photo
    @photo ||= store.photo
  end

end
