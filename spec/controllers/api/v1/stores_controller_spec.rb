require 'api_spec_helper'


describe Api::V1::StoresController, :search => true do
  before :each do

    @store1 = FactoryGirl.create(:store)
    @store2 = FactoryGirl.create(:store, :name => "Darryl's Dispensary", :slug => "darryls-dispensary")
    @store3 = FactoryGirl.create(:store, :name => "Ben's Buds")
  end

  it "should exist" do
    expect(Api::V1::StoresController).to be
  end

  it { should respond_to :index }
  it { should respond_to :show }

  describe "GET /api/v1/stores" do
    it "returns a list of stores" do
      get :index, format: :json
      expect(JSON.parse(response.body).length).to be(3)
      expect(response.body).to have_json_path('0/slug')
      expect(response.body).to be_json_eql(%|"123 High St"|).at_path('0/address')

      expect(response.body).to have_json_path('1/slug')
      expect(response.body).to be_json_eql(%|"Darryl's Dispensary"|).at_path('1/name')
    end
  end

  describe 'GET /api/v1/stores/:slug' do
    it 'returns the attributes for a store' do
      get :show, slug: @store2.slug, format: :json
      expect(response.body).to have_json_path('menu')
      expect(response.body).to be_json_eql(%|"Darryl's Dispensary"|).at_path("name")
    end
  end

end
