require 'spec_helper'

describe Store do
  let(:scraped) do
    {:stores=>[{:slug=>"denver-relief",
     :name=>"Denver Relief",
     :address=>"1 Broadway Suite A-150",
     :city=>"Denver",
     :state=>"CO",
     :zipcode=>" 80203",
     :hours=>" 8AM-6:45PM,
     7 days a week",
     :website=>"http://www.denverrelief.com",
     :phone_number=>"303.420.MEDS (6337)",
     :menu=>"[\"Bio - Diesel\",
     \"Bio - Jesus\",
     \"Blue Dream\"]"}]}
  end

  it "has reviews" do
    store = FactoryGirl.create(:store)
    review = store.reviews.create(FactoryGirl.attributes_for(:review))
    expect(store.reviews).to be
  end

  it "parses the JSON version of its menu" do
    store = FactoryGirl.create(:store)
    menu = store.menu_to_array
    expect(menu).to be_a_kind_of(Array)
    expect(menu.first).to eq("Banana Kush")
  end

  it "knows its name" do
    store = FactoryGirl.create(:store)
    expect(store.store_name).to eq("High Zone")
  end

  it "can run the scraper" do
    store = FactoryGirl.create(:store)
    Scraper.stub(:scrape_stores).and_return(scraped)
    stores = Store.scrape_and_save_to_database
    expect(stores).to be_a_kind_of(Array)
    expect(stores.first).to be_a_kind_of(Store)
    expect(stores.first.name).to eq("Denver Relief")
  end

end