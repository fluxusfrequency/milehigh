require 'spec_helper'

describe Review do

  it "validates presence of user id" do
    review1 = FactoryGirl.build(:review)
    review2 = FactoryGirl.build(:review, user_id: nil)
    expect(review1).to be_valid
    expect(review2).to_not be_valid
  end

  it "validates presence of store id" do
    review1 = FactoryGirl.build(:review)
    review2 = FactoryGirl.build(:review, store_id: nil)
    expect(review1).to be_valid
    expect(review2).to_not be_valid
  end

  it "validates rating of thumbs up or thumbs down" do
    review1 = FactoryGirl.build(:review)
    review2 = FactoryGirl.build(:review, rating: 'horrible')
    review3 = FactoryGirl.build(:review, rating: nil)
    expect(review1).to be_valid
    expect(review2).to_not be_valid
    expect(review3).to_not be_valid
  end

  it "validates presence of body" do
    review1 = FactoryGirl.build(:review)
    review2 = FactoryGirl.build(:review, body: '')
    review3 = FactoryGirl.build(:review, body: "i really really really
      reallyreally reallyreally reallyreally reallyreally reallyreally
      reallyreally reallyreallyreally reallyreally really really hated it")
    expect(review1).to be_valid
    expect(review2).to_not be_valid
    expect(review3).to_not be_valid
  end

  it "validates presence and length of title" do
    review1 = FactoryGirl.build(:review)
    review2 = FactoryGirl.build(:review, title: '')
    review3 = FactoryGirl.build(:review, title: 'HARSHING MY MELLLLLLLLLLLLLLLOW!!')
    expect(review1).to be_valid
    expect(review2).to_not be_valid
    expect(review3).to_not be_valid
  end

  it "knows its rating" do
    review = FactoryGirl.build(:review)
    expect(review.thumbs_up?).to be
    expect(review.thumbs_down?).not_to be
  end

  it "clips the title" do
    review = FactoryGirl.build(:review, title: 'HARSHING MY MELLLLLLLLLLLLLLLOW!')
    expect(review).to be_valid
    expect(review.short_title).to eq("HARSHING MY MELLLLL...")
  end

end
