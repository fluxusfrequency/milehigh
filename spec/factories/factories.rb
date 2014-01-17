FactoryGirl.define do
  factory :review do
    user_id 1
    store
    rating "Thumbs Up"
    title "SOOOO GREAT!"
    body "Really, it's that great"
  end

  factory :store do
    slug "high-zone"
    name "High Zone"
    address "123 High St"
    city "Denver"
    state "CO"
    zipcode "80206"
    hours "8-6pm"
    website "www.high-zone.com"
    phone_number "302-123-1234"
    menu "[\"Banana Kush\", \"BDS Special\", \"Blue Dream\", \"Cheese\"]"
  end
end

