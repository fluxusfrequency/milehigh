require 'json'

class Store < ActiveRecord::Base

  has_many :reviews
  validates :name, presence: true

  def self.find_by_strain(strain)
    all.select { |store| store.menu.include?(strain.name)}
  end

  def menu_to_array
    JSON.parse(self.menu)
  end

  def store_name
    self.try(:name)
  end

  def positive_count
    reviews.positive.count
  end

  def negative_count
    reviews.negative.count
  end

  def percent_positive
    ((positive_count.to_f / reviews.count.to_f)*100.00).floor
  end

  def percent_negative
    ((negative_count.to_f / reviews.count.to_f)*100.00).floor
  end

  def mostly_positive?
    percent_positive > 50
  end

  def total_reviews
    reviews.count
  end

  def photo
    @photo ||= "dispensary-#{(rand(4) + 1)}.jpg"
  end

end
