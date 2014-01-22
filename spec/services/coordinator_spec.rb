require 'service_spec_helper'

describe Coordinator do
  it "should exist" do
    expect(Coordinator).to be
  end

  it "should get the coordinates for a store" do
    VCR.use_cassette('coordinates') do
      store = FactoryGirl.create(:store, address: "2383 S. Downing Street", zipcode: "80210", lat: nil, lng: nil)
      Coordinator.get_coordinates(store)
      store.reload
      expect(store.lat).to eq("39.6733019")
      expect(store.lng).to eq("-104.9737813")
    end
  end
end