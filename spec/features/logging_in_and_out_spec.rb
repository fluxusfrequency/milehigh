describe "Logging in" do

  before do
    visit '/welcome'
    click_on 'Login With Facebook'
  end

  it "succeeds with Facebook" do
    expect(page).to have_content('Ben Horne')
  end

end
