require 'json'

class Store < ActiveRecord::Base

  has_many :reviews

  def self.scrape_and_save_to_database
    stores = Scraper.scrape_stores[:stores]
    stores.each_with_index do |store, index|
      create(store)
      puts "created store #{index}"
    end
  end

  def menu_to_array
    JSON.parse(self.menu)
  end

  def store_name
    self.try(:name)
  end

  searchable do
    text :name, :address, :menu,
         :city, :hours, :zipcode
  end
end
