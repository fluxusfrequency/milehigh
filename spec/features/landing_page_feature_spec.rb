require 'spec_helper'

  describe "guest visits site" do

    it "shows site information" do
      visit '/'
      expect(page).to have_content 'Mile High'
      expect(page).to have_content 'The Real Home of the Denver Nuggets'
    end

    it "displays footer" do
      visit '/'
      expect(page).to have_content 'A gSchool demonstration application by Darryl Pequeen, Bryana Knight, Ben Horne, and Ben Lewis.'
    end
  end

