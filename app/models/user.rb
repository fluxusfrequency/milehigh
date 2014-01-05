class User < ActiveRecord::Base
  validates_presence_of :full_name
  validates_presence_of :display_name
  validates_format_of   :email,
                        :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates             :email, uniqueness: true
end
