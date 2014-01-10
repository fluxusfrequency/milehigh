require 'json'

module Leafly
  class Store < ActiveRecord::Base
    has_many :reviews

    def self.scrape_and_save_to_database
      stores = Leafly::Scraper.scrape_stores[:stores]
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
  end
end
