require 'spec_helper'

describe Review do

  xit "validates presence of user id" do
    review1 = FactoryGirl.build(:review)
    review2 = FactoryGirl.build(:review, user_id: nil)
    expect(review1).to be_valid
    expect(review2).to_not be_valid
  end

  xit "validates presence of store id" do
    review1 = FactoryGirl.build(:review)
    review2 = FactoryGirl.build(:review, store_id: nil)
    expect(review1).to be_valid
    expect(review2).to_not be_valid
  end

  xit "validates rating of thumbs up or thumbs down" do
    review1 = FactoryGirl.build(:review)
    review2 = FactoryGirl.build(:review, rating: 'horrible')
    review3 = FactoryGirl.build(:review, rating: nil)
    expect(review1).to be_valid
    expect(review2).to_not be_valid
    expect(review3).to_not be_valid
  end

  xit "validates presence of body" do
    review1 = FactoryGirl.build(:review)
    review2 = FactoryGirl.build(:review, body: '')
    expect(review1).to be_valid
    expect(review2).to_not be_valid
  end

  xit "validates presence of title" do
    review1 = FactoryGirl.build(:review)
    review2 = FactoryGirl.build(:review, title: '')
    expect(review1).to be_valid
    expect(review2).to_not be_valid
  end



end
