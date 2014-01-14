require 'spec_helper'
require 'pry'

describe Search do

  describe 'single store' do
    before :each do
      login
    end

    it 'searches by store name' do
      store = FactoryGirl.create(:store)
      fill_in('query', with: store.name)
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
