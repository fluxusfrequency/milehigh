require 'spec_helper'


describe "strain show" do

  before do
    visit '/welcome'
    click_on 'Login With Facebook'
  end

  it "is reachable from store's menu page" do
    store = FactoryGirl.create(:store)
    menu = JSON.parse(store.menu)
    visit store_path(store)
    expect(page).to have_content(store.name)
    within ('#store-menu') do 
      click_link("#{menu[0]}")
    end
    expect(page).to have_content("Indica")
  end

end
