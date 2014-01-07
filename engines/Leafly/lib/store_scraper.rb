require 'mechanize'
require 'open-uri'

module Leafly
  module Scraper

    def self.urls
      [
      'http://www.leafly.com/dispensary-info/denver-relief',
      'http://www.leafly.com/dispensary-info/local-product-of-colorado'
      ]
    end

    def self.scrape_stores
      stores = []
      strains = []

      urls.each_with_index do |url, i|
        puts "scraping store #{i}"
        page = Nokogiri::HTML(open(url))
        slug = url.split(/\//).last
        name = slug.split("-").map(&:capitalize).join(" ")
        address = page.css(".map-address").first.children[1].children.first.text
        city = page.css(".map-address").first.children[3].children.first.text
        state = page.css(".map-address").first.children[5].children.first.text
        zipcode = page.css(".map-address").first.children[6].text
        hours = page.css(".dispensary-info-box").first.children[1].children[1].children[1].children[0].children[1].text
        website = page.css(".dispensary-info-box").first.children[1].children[1].children[1].children[4].children[2].attributes["href"].value
        phone_number = page.css(".dispensary-info-box").first.children[1].children[1].children[1].children[2].children[2].children[0].text
        stores << {
          :slug => slug,
          :name => name,
          :address => address,
          :city => city,
          :state => state,
          :zipcode => zipcode,
          :hours => hours,
          :website => website,
          :phone_number => phone_number}

        menu = Nokogiri::HTML(open(url + "/menu"))
        menu.css('.description').length.times do |i|
          strains << menu.css('.description')[i].children[1].children[0].children[0].text
        end
      end

      [stores, strains]

    end

  end
end