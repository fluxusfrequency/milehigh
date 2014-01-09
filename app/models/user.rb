class User < ActiveRecord::Base
  has_many :reviews

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
    graph = Koala::Facebook::API.new
    avatar_path = graph.get_picture(uid, :type => 'square')
    self.update_attributes(:avatar => avatar_path)
  end
end

