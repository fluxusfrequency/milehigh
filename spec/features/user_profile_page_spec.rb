require 'spec_helper'

describe "user profile" do
  it "displays a users information" do
    visit root_path 
    click_on "Login With Facebook"
    user = User.last
    # save_and_open_page
    click_on user.name
    expect(current_path).to eq(user_profile_path)
    expect(page).to have_content(user.name)
  end
end
