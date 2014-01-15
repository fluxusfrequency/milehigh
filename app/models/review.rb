class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :store, class_name: Leafly::Store

  validates :store_id, :body, :title, presence: true
  validates_inclusion_of :rating, :in => ['Thumbs Up', 'Thumbs Down']

  def self.most_recent(number)
    all.order(created_at: :desc).limit(number)
  end

  def self.thumbs_up?
    rating == "Thumbs Up"
  end

  def self.thumbs_down?
    rating == "Thumbs Down"
  end

  def store_name

  end

  def category_name
    category.try(:name)
  end

  def category_name=(name)
    self.category = Category.find_by_name(name) if name.present?
  end
end
