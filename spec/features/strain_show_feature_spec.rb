require 'spec_helper'


describe "strain show" do

  before do
    visit '/welcome'
    click_on 'Login With Facebook'
  end

  it "is reachable from store's menu page" do
    store = FactoryGirl.create(:store)
    strain = MenuStrain.by_store(store).first
    visit store_path(store)
    expect(page).to have_content(store.name)
    within ('#store-menu') do 
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

    # @key = data["Key"]
    # @id = data["Id"]
    # @name = data["Name"]
    # @category = data["Category"]
    # @description = data["Abstract"]
    # @symbol = data["Symbol"]
    # @overview = data["Overview"]
    # @url = data["Url"]
    # @rating = data["Rating"]
    # @effects = data["Effects"] #returns an array of hashes for each effect
    # @medical_uses = data["Medical"]
    # @side_effects = data["Negative"]
    # @reviews = data["Reviews"]

end
