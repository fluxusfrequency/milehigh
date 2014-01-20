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
  it { should respond_to :new }
  it { should respond_to :create }
  it { should respond_to :show }
  it { should respond_to :update }
  it { should respond_to :destroy }

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

  describe "GET /api/v1/stores/new" do
    it "returns a new recipe" do
      get :new, format: :json
      expect(response.body).to have_json_path('slug')
      expect(response.body).to have_json_path('name')
      expect(response.body).to have_json_path('address')
      expect(response.body).to have_json_path('menu')
    end
  end

  describe 'POST /api/v1/stores' do
    it 'returns a new store' do
      post :create, store: {
        "name" => "Bryana's Banana Kush",
        "slug" => "bryanas-banana-kush",
        "address" => "123 Migh St",
        "city" => "Denver",
        "state" => "CO",
        "zipcode" => "82206",
        "hours" => "8-1pm",
        "website" => "www.bbs-buds.com",
        "phone_number" => "302-123-1235",
        "menu" => "[\"Banana Krush\", \"BDS Special\", \"Blue Dream\", \"Cheese\"]"
        },
        format: :json
      response.body.should have_json_path('website')
      response.body.should be_json_eql(%|"Bryana's Banana Kush"|).at_path('name')
    end

    it "returns an error when missing params" do
      post :create, store: {
        "name" => "",
        "slug" => "bryanas-banana-kush",
        "address" => "123 Migh St",
        "city" => "Denver",
        "state" => "CO",
        "zipcode" => "82206",
        "hours" => "8-1pm",
        "website" => "www.bbs-buds.com",
        "phone_number" => "302-123-1235",
        "menu" => "[\"Banana Krush\", \"BDS Special\", \"Blue Dream\", \"Cheese\"]"
        },
        format: :json
      expect(response.status).to eql(400)
      expect(response.body).to be_json_eql(%|["can't be blank"]|).at_path("name")
    end
  end

  describe 'GET /api/v1/stores/:slug' do
    it 'returns the attributes for a store' do
      get :show, slug: @store2.slug, format: :json
      expect(response.body).to have_json_path('menu')
      expect(response.body).to be_json_eql(%|"Darryl's Dispensary"|).at_path("name")
    end
  end

  describe 'PUT /api/v1/stores/:slug' do
    it 'updates the params of a store' do
      put :update, slug: @store3.slug, store: {"address" => '420 Kush Ln.'}, format: :json
      expect(response.body).to be_json_eql(%|"420 Kush Ln."|).at_path("address")
    end
  end

  describe 'DELETE /api/v1/stores/:slug' do
    it 'deletes a store' do
      delete :destroy, slug: @store1.slug, format: :json
      expect { Store.find(@store1.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

end
