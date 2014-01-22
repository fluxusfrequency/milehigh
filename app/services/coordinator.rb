class Coordinator
  def self.get_coordinates(store)
    store_address = "#{store.address.strip.gsub(' ', '+')}+#{store.city}+#{store.state}"
    response = Faraday.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{store_address}&sensor=false")
    coords = JSON.parse(response.body)
    lat = coords["results"].first["geometry"]["location"]["lat"]
    lng = coords["results"].first["geometry"]["location"]["lng"]
    store.update_attributes(lat: lat, lng: lng)
  end
end