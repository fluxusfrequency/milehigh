module Scraper

  def self.dispensary_urls
    agent = Mechanize.new
    links = agent.get('http://www.leafly.com/medicalmarijuana/r/denver').links.map do |link|
      link.href
    end.compact

    links.select {| l| l.match(/\/dispensary-info/) }
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
