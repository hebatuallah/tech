class User < ActiveRecord::Base
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
  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
    rescue Koala::Facebook::APIError => e
      logger.info e.to_s
      nil
  end
  
  def find_locations
    #facebook { |fb| fb.get_connection("me", "locations") }
	checkins = facebook { |fb| fb.fql_query("SELECT latitude, longitude FROM location_post WHERE author_uid = me()") }
	locations = Array.new
    checkins.each { |item| locations.push({"l"=> item['latitude'], "n"=> item['longitude']}) } if checkins
    locations
  end
end
