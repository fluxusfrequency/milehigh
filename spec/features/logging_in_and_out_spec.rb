require 'spec_helper'

describe "Logging in" do

  before :each do
    login
  end

  it "succeeds with Facebook" do
    expect(page).to have_content('Ben Horne')
  end

  it "logs out" do
    click_on "Sign out"
    expect(page).to have_content('Login With Facebook')
    expect(current_path).to eq(welcome_path)
  end

end
