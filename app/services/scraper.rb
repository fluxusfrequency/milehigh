require 'mechanize'
require 'open-uri'

module Scraper

  def self.dispensary_urls
    ["/dispensary-info/local-product-of-colorado", "/dispensary-info/denver-relief", "/dispensary-info/the-green-solution4afc", "/dispensary-info/the-green-solutionaf50", "/dispensary-info/green-cross-of-cherry-creek", "/dispensary-info/karmaceuticals", "/dispensary-info/infinite-wellness-center-", "/dispensary-info/natural-remedies", "/dispensary-info/mbs-wellness-clinic", "/dispensary-info/kind-love", "/dispensary-info/ivita-wellness", "/dispensary-info/light-shade-labs-40th-ave", "/dispensary-info/lightshade-labs-holly", "/dispensary-info/herban-medicinals", "/dispensary-info/the-wellness-shop", "/dispensary-info/cure-colorado", "/dispensary-info/ballpark-holistic-dispensary", "/dispensary-info/strainwise-the-ridge", "/dispensary-info/medicinal-wellness-center", "/dispensary-info/colorado-care-facility", "/dispensary-info/dank-colorado", "/dispensary-info/northwest-wellness-center", "/dispensary-info/lincoln-herbal", "/dispensary-info/northern-lights-natural-rx", "/dispensary-info/sticky-buds", "/dispensary-info/expanding-universe", "/dispensary-info/herbal-remedies055f", "/dispensary-info/denver-kush-club", "/dispensary-info/the-giving-tree-of-denver", "/dispensary-info/allgreens", "/dispensary-info/timberline-herbal-clinic---wellness-center", "/dispensary-info/chronorado", "/dispensary-info/altitude-organic-medicine-south6c8a", "/dispensary-info/pink-house-mile-high", "/dispensary-info/leagle-services-llc", "/dispensary-info/metro-cannabis-inc", "/dispensary-info/riverside-wellness", "/dispensary-info/the-herbal-cure", "/dispensary-info/the-pearl-co", "/dispensary-info/the-health-center", "/dispensary-info/cannabis-station", "/dispensary-info/rocky-mountain-high-denver", "/dispensary-info/strainwise-the-sanctuary", "/dispensary-info/strainwise-the-reserve", "/dispensary-info/strainwise-the-retreat", "/dispensary-info/metropolis-medical", "/dispensary-info/mile-high-medical-cannabis", "/dispensary-info/wellspring-collective", "/dispensary-info/the-health-center-uptown", "/dispensary-info/3-d-denvers-discreet-dispensary", "/dispensary-info/strainwise-the-shelter", "/dispensary-info/denco-alternative-medicine", "/dispensary-info/strainwise-the-haven", "/dispensary-info/bud-cellar", "/dispensary-info/little-green-pharmacy", "/dispensary-info/greenwerkz-edgewater", "/dispensary-info/bgoods-apothecary", "/dispensary-info/grassroots-grown", "/dispensary-info/advanced-medical-alternatives", "/dispensary-info/southwest-alternative-care57fe", "/dispensary-info/the-clinic-on-colfax", "/dispensary-info/herbal-wellness-", "/dispensary-info/caregivers-for-life", "/dispensary-info/greenwerkz", "/dispensary-info/the-releaf-center", "/dispensary-info/the-cherry-co", "/dispensary-info/walking-raven", "/dispensary-info/element-four20", "/dispensary-info/herbs-nest", "/dispensary-info/a-cut-above", "/dispensary-info/high-street-growers", "/dispensary-info/summit-wellness", "/dispensary-info/colorado-wellness-inc", "/dispensary-info/back-to-the-garden6db0", "/dispensary-info/at-home-remedies-inc", "/dispensary-info/kind-pain-management", "/dispensary-info/fox-street-wellness", "/dispensary-info/artisanal-medicinals", "/dispensary-info/globeville-meds", "/dispensary-info/the-clinic-on-holly", "/dispensary-info/420-wellness-north", "/dispensary-info/lohi-cannabis-club", "/dispensary-info/blue-sky-everyday", "/dispensary-info/mayflower-wellness", "/dispensary-info/green-meadows", "/dispensary-info/nature-s-kiss", "/dispensary-info/cure-dispensary", "/dispensary-info/kindness", "/dispensary-info/alameda-wellness", "/dispensary-info/colorado-apothecary---wellness-center", "/dispensary-info/rocky-mountain-organics", "/dispensary-info/a-mile-high-llc", "/dispensary-info/doctor-s-orders", "/dispensary-info/alternative-wellness-center", "/dispensary-info/patients-choice-of-colorado-lakewood", "/dispensary-info/health-depotc274", "/dispensary-info/mile-high-wellness76b9", "/dispensary-info/urban-cannabis", "/dispensary-info/postmodern-health", "/dispensary-info/burnzwell-mmc", "/dispensary-info/medicine-man-glendale-dispensary", "/dispensary-info/kindman", "/dispensary-info/the-clinic", "/dispensary-info/lodo-wellness-center", "/dispensary-info/emerald-city-organics-kalamath", "/dispensary-info/altitude-wellness", "/dispensary-info/citi-med"]
  end

  def self.scrape_stores(urls)
    results = {:stores => []}

    urls.each_with_index do |url, i|
      begin
        puts "scraping store #{i}"
        page = Nokogiri::HTML(open("http://www.leafly.com" + url))
        slug = url.split(/\//).last
        name = slug.split("-").map(&:capitalize).join(" ")
        address = page.css(".map-address").first.children[1].children.first.text
        city = page.css(".map-address").first.children[3].children.first.text
        state = page.css(".map-address").first.children[5].children.first.text
        zipcode = page.css(".map-address").first.children[6].text
        hours = page.css(".dispensary-info-box").first.children[1].children[1].children[1].children[0].children[1].text
        website = page.css(".dispensary-info-box").first.children[1].children[1].children[1].children[4].children[2].attributes["href"].value
        phone_number = page.css(".dispensary-info-box").first.children[1].children[1].children[1].children[2].children[2].children[0].text
        menu = []

        begin
          menu_page = Nokogiri::HTML(open("http://www.leafly.com" + url + "/menu"))
          menu_page.css('.description').length.times do |i|
            menu << menu_page.css('.description')[i].children[1].children[0].children[0].text
          end
          menu
        rescue
          puts "Failed to load menu for #{url} :<"
        end

        results[:stores] << {
          :slug => slug,
          :name => name,
          :address => address,
          :city => city,
          :state => state,
          :zipcode => zipcode,
          :hours => hours,
          :website => website,
          :phone_number => phone_number,
          :menu => menu.to_s || nil }

      rescue
        puts "Failed to fully load store #{i} - #{url} :("
      end
    end

    results

  end

  def self.scrape_and_save_to_database
    scraped = Scraper.scrape_stores(Scraper.dispensary_urls)[:stores]

    stores = []
    scraped.each_with_index do |store, index|
      created = Store.create(store)
      stores << created
      puts "created store #{index}"
    end
    Store.all.each do |store|
      Coordinator.get_coordinates(store)
      stores << store
    end
    stores
  end

end
