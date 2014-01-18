require 'api_spec_helper'

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

    xit "provides a useful error if user doesn't exist"
    xit "provides a useful error if store doesn't exist"
    xit ""
  end


end



