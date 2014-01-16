require 'spec_helper'

describe Search do

  describe 'single store' do

    before :each do
      login
    end


    it 'searches by store name', :search => true do
      store = FactoryGirl.create(:store)
      Store.stub(:search).and_return(store)
      store.stub(:results).and_return([store])
      within(".longstory") do
        page.fill_in 'search-form', with: store.name
      end
      click_on 'Search'
      within('#search-results') do
        expect(page).to have_content(store.name)
      end
    end
  end

  def login
    visit root_path
    click_on 'Login With Facebook'
  end


end
