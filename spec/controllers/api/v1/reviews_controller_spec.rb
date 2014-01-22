require 'api_spec_helper'
require 'pry'

describe Api::V1::ReviewsController, :search => true do
  let!(:store) { FactoryGirl.create(:store) }
  let!(:review1) { FactoryGirl.create(:review, store_id: store.id) }
  let!(:review2) { FactoryGirl.create(:review, store_id: store.id) }
  let!(:review3) { FactoryGirl.create(:review, store_id: store.id) }

  describe "GET /api/v1/reviews" do

    it "returns a list of reviews" do
      get :index, format: :json
      body = JSON.parse(response.body)
      expect(body.length).to eq Review.all.count
      expect(body[0]['body']).to eq review1.body
    end
  end

  describe 'POST /api/v1/review' do
    it 'returns an error message if submitting new review with invalid store' do
      post :create, format: :json, review: {
        "user_id" => "10",
        "store_id" => "11",
        "title" => "Awesome weed",
        "body" => "So good",
        "rating" => "Thumbs Up"
      }
      hash = JSON.parse(response.body)
      expect(hash).to eq ['not a valid store']
    end

    it 'returns review when valid review created' do
      post :create, format: :json, review: {
        "user_id" => "10",
        "store_id" => "#{store.id}",
        "title" => "Awesome weed",
        "body" => "So good",
        "rating" => "Thumbs Up"
      }
      hash = JSON.parse(response.body)
      expect(hash.length).to eq 8
    end

  end

  describe 'GET /api/v1/review/:id' do
    it 'returns the attributes for a review' do
      get :show, id: review2.id, format: :json
      hash = JSON.parse(response.body)
      expect(hash["id"]).to eq review2.id
      expect(hash["title"]).to eq review2.title
      expect(hash["body"]).to eq review2.body
    end
  end

  describe 'GET /api/v1/review/store/:slug' do
    it "returns all the reviews for the store with given slug" do
      get :for_store, slug: store.slug, format: :json
      results = JSON.parse(response.body)
      expect(results.first['slug']).to eq(store.slug)
      expect(results.last['title']).to eq(review3.title)
    end
  end

end
