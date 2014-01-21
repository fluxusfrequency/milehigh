require 'spec_helper'


describe "strain show" do

  before do
    login
  end

  it "is reachable from store's menu page" do
    store = FactoryGirl.create(:store)
    strain = MenuStrain.by_store(store).first
    visit store_path(store.slug)
    expect(page).to have_content(store.name)
    click_link(strain.name)
    expect(current_path).to include(strain.key)
    expect(page).to have_content(strain.name)
    expect(page).to have_content(strain.category)
    expect(page).to have_content(strain.description)
    expect(page).to have_content(strain.overview)
    expect(page).to have_content(strain.rating)
    expect(page).to have_content(strain.effects)
    expect(page).to have_content(strain.medical_uses)
    expect(page).to have_content(strain.side_effects)
  end

  it "has a list of stores that carry the strain" do 
    store1 = FactoryGirl.create(:store)
    store2 = FactoryGirl.create(:store, :name => "Bryana's Buds")
    strain = MenuStrain.by_store(store1).first
    visit strain_show_path(strain.key)
    within("#strain-stores") do 
      expect(page).to have_content(store2.name)
      expect(page).to have_content(store1.name)
      expect(page).to have_content(store1.address)
      expect(page).to have_content(store2.address)
    end

  end

end
