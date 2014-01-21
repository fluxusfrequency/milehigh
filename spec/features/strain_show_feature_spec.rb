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
    within ('#menu-icon-container') do
      click_link(strain.name)
    end
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

end
