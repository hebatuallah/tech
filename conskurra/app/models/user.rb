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
   checkins = 
    [
      {
        "id"=> "10151187856851303", 
        "from"=> {
          "name"=> "Hebatu-Allah Fahmy", 
          "id"=> "631706302"
        }, 
        "tags"=> {
          "data"=> [
            {
              "name"=> "Fahmyibrahim Saad", 
              "id"=> "1232037551"
            }, 
            {
              "name"=> "Hebatu-Allah Fahmy", 
              "id"=> "631706302"
            }
          ]
        }, 
        "type"=> "photo", 
        "place"=> {
          "id"=> "115351105145884", 
          "name"=> "Cairo, Egypt", 
          "location"=> {
            "street"=> "", 
            "zip"=> "", 
            "latitude"=> 37.0581, 
            "longitude"=> 31.2289
          }
        }, 
        "application"=> {
          "name"=> "Photos", 
          "id"=> "2305272732"
        }, 
        "created_time"=> "2012-08-20T12:47:32+0000"
      }, 
      {
        "id"=> "10151187850846303", 
        "from"=> {
          "name"=> "Hebatu-Allah Fahmy", 
          "id"=> "631706302"
        }, 
        "tags"=> {
          "data"=> [
            {
              "name"=> "Fahmyibrahim Saad", 
              "id"=> "1232037551"
            }, 
            {
              "name"=> "Hebatu-Allah Fahmy", 
              "id"=> "631706302"
            }
          ]
        }, 
        "type"=> "photo", 
        "place"=> {
          "id"=> "115351105145884", 
          "name"=> "Cairo, Egypt", 
          "location"=> {
            "street"=> "", 
            "zip"=> "", 
            "latitude"=> -25.363882,
            "longitude"=> 131.044922
          }
        }, 
        "application"=> {
          "name"=> "Photos", 
          "id"=> "2305272732"
        }, 
        "created_time"=> "2012-08-20T12:43:45+0000"
      }, 
      {
        "id"=> "10151187846116303", 
        "from"=> {
          "name"=> "Hebatu-Allah Fahmy", 
          "id"=> "631706302"
        }, 
        "tags"=> {
          "data"=> [
            {
              "name"=> "Hebatu-Allah Fahmy", 
              "id"=> "631706302"
            }
          ]
        }, 
        "type"=> "photo", 
        "place"=> {
          "id"=> "115351105145884", 
          "name"=> "Cairo, Egypt", 
          "location"=> {
            "street"=> "", 
            "zip"=> "", 
            "latitude"=> 70.0581, 
            "longitude"=> 91.2289
          }
        }, 
        "application"=> {
          "name"=> "Photos", 
          "id"=> "2305272732"
        }, 
        "created_time"=> "2012-08-20T12:40:44+0000"
      }, 
      {
        "id"=> "10151187842641303", 
        "from"=> {
          "name"=> "Hebatu-Allah Fahmy", 
          "id"=> "631706302"
        }, 
        "tags"=> {
          "data"=> [
            {
              "name"=> "Hebatu-Allah Fahmy", 
              "id"=> "631706302"
            }
          ]
        }, 
        "type"=> "photo", 
        "place"=> {
          "id"=> "115351105145884", 
          "name"=> "Cairo, Egypt", 
          "location"=> {
            "street"=> "", 
            "zip"=> "", 
            "latitude"=> 100.0581, 
            "longitude"=> 91.2289
          }
        }, 
        "application"=> {
          "name"=> "Photos", 
          "id"=> "2305272732"
        }, 
        "created_time"=> "2012-08-20T12:38:26+0000"
      }, 
      {
        "id"=> "10151187836281303", 
        "from"=> {
          "name"=> "Hebatu-Allah Fahmy", 
          "id"=> "631706302"
        }, 
        "tags"=> {
          "data"=> [
            {
              "name"=> "Hebatu-Allah Fahmy", 
              "id"=> "631706302"
            }
          ]
        }, 
        "type"=> "photo", 
        "place"=> {
          "id"=> "115351105145884", 
          "name"=> "Cairo, Egypt", 
          "location"=> {
            "street"=> "", 
            "zip"=> "", 
            "latitude"=> -12.0581, 
            "longitude"=> 39.2289
          }
        }, 
        "application"=> {
          "name"=> "Photos", 
          "id"=> "2305272732"
        }, 
        "created_time"=> "2012-08-20T12:33:29+0000"
      }, 
      {
        "id"=> "67923731302", 
        "from"=> {
          "name"=> "Hebatu-Allah Fahmy", 
          "id"=> "631706302"
        }, 
        "tags"=> {
          "data"=> [
            {
              "name"=> "Hebatu-Allah Fahmy", 
              "id"=> "631706302"
            }, 
            {
              "name"=> "Zinab Mohammed Ali", 
              "id"=> "529845992"
            }
          ]
        }, 
        "type"=> "photo", 
        "place"=> {
          "id"=> "115351105145884", 
          "name"=> "Cairo, Egypt", 
          "location"=> {
            "street"=> "", 
            "zip"=> "", 
            "latitude"=> 99.0581, 
            "longitude"=> 34.2289
          }
        }, 
        "application"=> {
          "name"=> "Photos", 
          "id"=> "2305272732"
        }, 
        "created_time"=> "2009-02-13T20:47:13+0000"
      }
    ] 
   locations = Array.new
   checkins.each do |item|
    lat = item['place']['location']['latitude']
    long = item['place']['location']['longitude']
    locations.push({"l"=> lat, "n"=> long})
   end
    locations
  end
end
