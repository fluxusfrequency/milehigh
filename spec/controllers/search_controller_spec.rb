require 'spec_helper'

describe SearchController do
  describe "GET" do
    let(:store) { FactoryGirl.create(:store) }


    xit "redirects to appropriate stores#show if store exists" do
      expect(get :new, {query: store.name}).to redirect_to("/leafly/stores/#{store.id}")
      # follow_redirect!
    end
  end
end
