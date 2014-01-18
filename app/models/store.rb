require 'json'

class Store < ActiveRecord::Base

  has_many :reviews
  validates :name, presence: true
  # after_save :get_coordinates

  def self.scrape_and_save_to_database
    scraped = Scraper.scrape_stores(Scraper.dispensary_urls)[:stores]

    stores = []
    scraped.each_with_index do |store, index|
      created = create(store)
      stores << created
      puts "created store #{index}"
    end
    all.each do |store|
      store.get_coordinates
      stores << store
    end
    stores
  end

  def get_coordinates
    store_address = "#{self.address.strip.gsub(' ', '+')}+#{self.city}+#{self.state}"
    response = Faraday.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{store_address}&sensor=false")
    coords = JSON.parse(response.body)
    lat = coords["results"].first["geometry"]["location"]["lat"]
    lng = coords["results"].first["geometry"]["location"]["lng"]
    self.update_attributes(lat: lat, lng: lng)
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

  searchable do
    text :name, :address, :menu,
         :city, :hours, :zipcode, :slug
  end
end
