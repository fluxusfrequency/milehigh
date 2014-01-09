FactoryGirl.define do
  factory :store, class: Leafly::Store do
    slug "high-zone"
    name "High Zone"
    address "123 High St"
    city "Denver"
    state "CO"
    zipcode "80206"
    hours "8-6pm"
    website "www.high-zone.com"
    phone_number "302-123-1234"
    menu "purple kush, ak-47"
  end
end
