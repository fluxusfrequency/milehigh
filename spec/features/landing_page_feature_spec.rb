require 'spec_helper'


  describe "guest visits site" do

    it "shows site information" do
      visit '/'
      expect(page).to have_content 'Mile High'
    end

    it "displays footer" do 
      visit '/'
      expect(page).to have_content 'Github'
    end
  end

