require 'json'

module Leafly
  class Store < ActiveRecord::Base

    def self.scrape_and_save_to_database
      stores = Leafly::Scraper.scrape_stores[:stores]
      puts stores
      stores.each {|store| create(store)}
    end

    def menu_to_array
      JSON.parse(self.menu)
    end
  end
end
