require 'spec_helper'


describe "strain show" do

  before :each do
    login
    Strain.stub(:all_strains).and_return([])
    @strain = Strain.new({
      "Category" => "Hybrid",
      "Description" => "Dank Chron",
      "Name" => "Banana Kush",
      "Effects" => ["something", "else"],
      "Id" => 1104,
      "Key" => "banana-kush",
      "Medical" => [{"Name" => "pain relief", "Score" => "13"}],
      "Overview" => "its good",
      "Rating" => 7.81,
      "Reviews" => ["1. I liked it"],
      "Negative" => [{"effect" => "dizziness"}],
      "Symbol" => "100",
      "Url" => "http://www.leafly.com/hybrid/100-og"})
    Strain.stub(:find_by_key).and_return(@strain)
  end

  it "is reachable from store's menu page" do
    store = FactoryGirl.create(:store)
    visit store_path(store.slug)
    expect(page).to have_content(store.name)
    save_and_open_page
    click_link(@strain.name)
    expect(page).to have_content(@strain.name)
    expect(page).to have_content(@strain.category)
    expect(page).to have_content(@strain.description)
    expect(page).to have_content(@strain.overview)
    expect(page).to have_content(@strain.rating)
    expect(page).to have_content(@strain.effects)
    expect(page).to have_content(@strain.medical_uses)
    expect(page).to have_content(@strain.side_effects)
  end

  it "has a list of stores that carry the strain" do
    store1 = FactoryGirl.create(:store)
    store2 = FactoryGirl.create(:store, :name => "Bryana's Buds")
    visit strain_show_path(@strain.key)
    within("#strain-stores") do
      expect(page).to have_content(store2.name)
      expect(page).to have_content(store1.name)
      expect(page).to have_content(store1.address)
      expect(page).to have_content(store2.address)
    end

  end

end
