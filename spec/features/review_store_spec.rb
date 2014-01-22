require 'spec_helper'
describe "review section" do

    before :each do
      @user = FactoryGirl.create(:user)
      login
      Strain.stub(:all_strains).and_return([])
    end

  it "appears on button click", :js => true do
    store = FactoryGirl.create(:store, name: "snoop's house")
    fill_in("store_name", :with => "snoop's house")
    click_on 'Review Store'
    expect(page).to have_content("Review snoop's house")
  end

  it "shows the store details on button click", :js => true do
    store = FactoryGirl.create(:store)
    fill_in("store_name", :with => "High Zone")
    click_on 'Review Store'
    within "#review-store-info" do
      expect(page).to have_content("High Zone - Store Info")
      expect(page).to have_content("123 High St, Denver, CO, 80206")
      expect(page).to have_content("8-6pm")
      expect(page).to have_content("www.high-zone.com")
      expect(page).to have_content("302-123-1234")
    end
  end

  it "can create a new positive review", :js => true do
    store = FactoryGirl.create(:store)
    store2 = FactoryGirl.create(:store, name: "snoop's house")
    store2.reviews.create(FactoryGirl.attributes_for(:review, user_id: @user.id))
    fill_in("store_name", :with => "snoop's house")
    click_on 'Review Store'
    expect(page).to have_content("Review Store")
    fill_in('Title', :with => 'awwwwwwwwesohm')
    fill_in('review_body', :with => 'truuuuuly delish nug')
    find('#thumbs-up').click
    Review.last.update_attributes(user_id: @user.id)

    # Page should be store show
    expect(current_path).to eq(store_path('high-zone'))

    expect(page).to have_content("Your review of #{store2.name} was successfully created!")

    # TO DO - Add reviews to store show page
    # expect(page).to have_content("awwwwwwwwesohm")
  end

  it "has an error when params are missing from positive review", :js => true do
    store = FactoryGirl.create(:store)
    store2 = FactoryGirl.create(:store, name: "snoop's house")
    store2.reviews.create(FactoryGirl.attributes_for(:review))
    fill_in("store_name", :with => "snoop's house")
    click_on 'Review Store'
    expect(page).to have_content("Review snoop's house")
    fill_in('Title', :with => '')
    fill_in('review_body', :with => 'truuuuuly delish nug')
    find('#thumbs-up').click
    expect(page).to have_content("Errors prevented your review from being created:")

    expect(page).to_not have_content("awwwwwwwwesohm")
  end

  it "can create a new negative review", :js => true do
    store = FactoryGirl.create(:store)
    store2 = FactoryGirl.create(:store, name: "snoop's house")
    store2.reviews.create(FactoryGirl.attributes_for(:review))
    fill_in("store_name", :with => "snoop's house")
    click_on 'Review Store'
    expect(page).to have_content("Review snoop's house")
    fill_in('Title', :with => 'awwwwwwwwesohm')
    fill_in('review_body', :with => 'truuuuuly delish nug')
    find('#thumbs-down').click
    Review.last.update_attributes(user_id: @user.id)

    # Page should be store show
    expect(current_path).to eq(store_path('high-zone'))

    expect(page).to have_content("Your review of #{store2.name} was successfully created!")

    # TO DO - uncomment this when reviews are added to store show page
    # expect(page).to have_content("awwwwwwwwesohm")
  end

  it "has an error when params are missing from negative review", :js => true do
    store = FactoryGirl.create(:store)
    store2 = FactoryGirl.create(:store, name: "snoop's house")
    store2.reviews.create(FactoryGirl.attributes_for(:review))
    fill_in("store_name", :with => "snoop's house")
    click_on 'Review Store'
    expect(page).to have_content("Review snoop's house")
    fill_in('Title', :with => '')
    fill_in('review_body', :with => 'truuuuuly delish nug')
    find('#thumbs-down').click
    expect(page).to have_content("Errors prevented your review from being created:")
    expect(page).to_not have_content("awwwwwwwwesohm")
  end

end
