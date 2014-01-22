FactoryGirl.define do
  factory :review do
    user_id 1
    store_id 1
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
    lat "39"
    lng "-104"
  end

  factory :user do
    provider "facebook"
    uid "12456"
    name "Bryana Knight"
    oauth_token "GABCDEF..."
    oauth_expires_at 'Thu, 22 Mar 2018 19:33:25 UTC +00:00'
    avatar "/"
  end

end

