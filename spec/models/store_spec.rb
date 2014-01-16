require 'spec_helper'

describe Store do

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

end