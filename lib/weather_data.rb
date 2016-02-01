class WeatherData
  attr_accessor :temparature, :description, :icon

  def icon_url
    return [ 'http://openweathermap.org/img/w/', @icon, '.png' ].join()
  end  
end 
