require 'spec_helper'
require 'pry'
describe "review section" do

    before :each do
      @user = FactoryGirl.create(:user)
      login
    end

  it "appears" do
    store = FactoryGirl.create(:store)
    expect(page).to have_content("Review Store")
  end

  it "can create a new positive review", :js => true do
    store = FactoryGirl.create(:store)
    store2 = FactoryGirl.create(:store, name: "snoop's house")
    store2.reviews.create(FactoryGirl.attributes_for(:review, user_id: @user.id))
    fill_in("store_name", :with => "snoop's house")
    click_on 'Review Store'
    expect(page).to have_content("Review snoop's house")
    fill_in('Title', :with => 'awwwwwwwwesohm')
    fill_in('review_body', :with => 'truuuuuly delish nug')
    find('#thumbs-up').click
    Review.last.update_attributes(user_id: @user.id)
    expect(page).to have_content("Your review of #{store2.name} was successfully created!")
    visit root_path
    within("#public-feed") do
      expect(page).to have_content("awwwwwwwwesohm")
    end
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
    within("#review-feed") do
      expect(page).to_not have_content("awwwwwwwwesohm")
    end
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

    expect(page).to have_content("Your review of #{store2.name} was successfully created!")
    visit root_path

    within("#public-feed") do
      expect(page).to have_content("awwwwwwwwesohm")
    end
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
    within("#review-feed") do
      expect(page).to_not have_content("awwwwwwwwesohm")
    end
  end

end
