
require 'pry'
require 'spec_helper'

describe "Review Feed" do

  before :each do
    visit root_path
    click_on "Login With Facebook"
  end


  it "has the title The Buzz" do
    visit welcome_path
    click_on "Login With Facebook"
    within('#review-feed') do
      expect(page).to have_content('The Buzz')
    end
  end

  it "has the six most recent reviews", :js => true do
    store = FactoryGirl.create(:store)
    review = store.reviews.create(FactoryGirl.attributes_for(:review, :title => 'my Braaaain hurts'))
    5.times do
      store.reviews.create(FactoryGirl.attributes_for(:review))
    end
    visit welcome_path
    click_on "Login With Facebook"
    within('#review-feed') do
      expect(page).to have_content(review.title)
    end
    FactoryGirl.create(:review)
    visit root_path
    within('#review-feed') do
      expect(page).to_not have_content(review.title)
    end
  end

end
