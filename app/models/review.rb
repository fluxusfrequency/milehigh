class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :store, class_name: Leafly::Store
end
