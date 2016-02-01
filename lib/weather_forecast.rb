require 'httparty'
require 'weather_data'

class WeatherForecast
  include HTTParty

  base_uri Rails.application.secrets.uri

  def show
    @data = get_data
    @data
  end
  
  private

  def get_data
    #options = "id=#{Rails.application.secrets.city_id}&lang=#{Rails.application.secrets.lang}&units=#{Rails.application.secrets.units}&appid=#{Rails.application.secrets.api_key}"
    #ap options 
    options = { query: {
        id: Rails.application.secrets.city_id,                     #id der stadt
        lang: Rails.application.secrets.lang,                      #damit in deutsch
        units: Rails.application.secrets.units,                    #damit celsius   
        appid: Rails.application.secrets.api_key                   #api-key
      }
    }
    #response = JSON.parse self.class.get("/weather?#{options}").body
    response = JSON.parse self.class.get("/weather", options).body
    WeatherData.new.tap do |w|
      #w.temparature = [ delta['main']['temp'], '°' ].join()
      w.temparature = [response['main']['temp'], '°' ].join()
      w.description = response['weather'][0]['description']
      w.icon = response['weather'][0]['icon']
    end  
  end  

end

# wetter.com
# http://api.wetter.com/location/index/search/53177/project/railsapp/cs/a7199ef34930a2e9255a391dfa8077cb um city code herauszufinden
# 090dba809ddcb6cf93bc6ac6f7e11d6f api key
# a7199ef34930a2e9255a391dfa8077cb checksumme ( = Digest::MD5.hexdigest('railsapp' '090dba809ddcb6cf93bc6ac6f7e11d6f' '53177') )
# city code: DE0001330
# checksumme für forecast: ( = Digest::MD5.hexdigest('railsapp' '090dba809ddcb6cf93bc6ac6f7e11d6f' 'DE0001330') = d1b6a817b486b5b1dbcc824b861f7d94 )
# http://api.wetter.com/forecast/weather/city/DE0001330/project/railsapp/cs/d1b6a817b486b5b1dbcc824b861f7d94

# openweathermap.org
# api-key: 120a8ecb3acf7dd29051d6c0b3a571ad
# http://api.openweathermap.org/data/2.5/weather?id=2946447&appid=120a8ecb3acf7dd29051d6c0b3a571ad
#
# http://api.openweathermap.org/data/2.5/forecast/daily?id=2946447&lang=de&units=metric&appid=120a8ecb3acf7dd29051d6c0b3a571ad

# http://api.openweathermap.org/data/2.5/weather?id=2946447&lang=de&units=metric&appid=120a8ecb3acf7dd29051d6c0b3a571ad

# http://openweathermap.org/img/w/10d.png



