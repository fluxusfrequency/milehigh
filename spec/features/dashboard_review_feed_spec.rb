
require 'pry'
require 'spec_helper'

describe "Review Feed" do

  it "has the title The Buzz" do
    login
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
    login
    within('#review-feed') do
      expect(page).to have_content(review.title)
    end
    FactoryGirl.create(:review)
    visit root_path
    within('#review-feed') do
      expect(page).to_not have_content(review.title)
    end
  end

  it "has the rating count for a store on a review", :js => true do
    store = FactoryGirl.create(:store)
    review = store.reviews.create(FactoryGirl.attributes_for(:review, :rating => 'Thumbs Up'))
    login

    within("#review-#{review.id}") do
      within("#review-counts") do
        expect(page).to have_content(store.positive_count)
      end
      within("#review-counts") do
        expect(page).to have_content(store.negative_count)
      end
    end

    store.reviews.create(FactoryGirl.attributes_for(:review, :rating => 'Thumbs Down'))
    store.reviews.create(FactoryGirl.attributes_for(:review, :rating => 'Thumbs Up'))

    visit root_path

    within("#review-#{review.id}") do
      within("#review-counts") do
        expect(page).to have_content(store.positive_count)
      end
      within("#review-counts") do
        expect(page).to have_content(store.negative_count)
      end
    end

  end



end
