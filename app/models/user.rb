class User < ActiveRecord::Base
  has_many :reviews

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def find_avatar
    avatar_path = facebook.get_picture(uid, :type => 'square')
    self.update_attributes(:avatar => avatar_path)
  end

  def all_friends
    @friend_data ||= facebook.get_connection("me", "friends")
    @friend_data.collect do |friend|
      Friend.new(friend["name"], friend["id"], @facebook)
    end
  end

  def friends_on_milehigh
    all_friend_ids = all_friends.map {|f| f.id}
    User.all.select {|user| all_friend_ids.include? user.uid}
  end

  def friend_reviews
    return [] if friends_on_milehigh.empty?
    friends_on_milehigh.collect do |user|
      user.reviews
    end.first.sort_by{|s| s.created_at}.reverse
  end

end

