require 'spec_helper'


  describe "individual store page" do

    it "displays name of store" do
      FactoryGirl.create(:store)
      visit '/leafly/stores/1'
      expect(page).to have_content 'High Zone'
      expect(page).to have_content '123 High St'
      expect(page).to have_content 'Denver'
      expect(page).to have_content 'CO'
      expect(page).to have_content '80206'
      expect(page).to have_content '8-6pm'
      expect(page).to have_content 'www.high-zone.com'
      expect(page).to have_content '302-123-1234'
    end

  end
