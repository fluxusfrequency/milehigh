require 'spec_helper'

describe "Logging in" do

  before do
    visit '/welcome'
    click_on 'Login With Facebook'
  end

  it "succeeds with Facebook" do
    # save_and_open_page
    expect(page).to have_content('Ben Horne')
  end

end
