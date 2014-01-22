require 'spec_helper'

describe "user profile" do


  it "displays a users information" do
    login
    user = User.last
    click_on user.name
    expect(current_path).to eq(user_profile_path)
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.created_at.strftime("%m/%d/%Y"))

    thumbs_up_review_count = user.reviews.where(rating: "Thumbs Up").count
    thumbs_down_review_count = user.reviews.where(rating: "Thumbs Down").count
    expect(page).to have_content('Total Reviews')
    within('#user-review-counts') do
      expect(page).to have_content("#{thumbs_up_review_count}")
      expect(page).to have_content("#{thumbs_down_review_count}")
    end
  end
end
