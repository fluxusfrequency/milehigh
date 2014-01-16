require 'spec_helper'

describe "Logging in" do

  before do
    visit root_path
    click_on 'Login With Facebook'
  end

  it "succeeds with Facebook" do
    expect(page).to have_content('Ben Horne')
  end

end
