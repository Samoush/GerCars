require 'rails_helper'
require 'weather_forecast'

RSpec.describe "Weather Viewing", type: :request do 
  it 'creates a new Object WeatherData and saves the current data in it' do
    weather_forec = WeatherForecast.new()
    data = weather_forec.show
    
    #ap data

    expect(data.temparature).to_not be_nil
    expect(data.description).to_not be_nil
    #expect(data.icon).to_not be_nil
  end  

  #it 'requests the index page and views the current weather' do
  #  weather_forec = WeatherForecast.new()
  #  forecast_data = weather_forec.show
  #  ap forecast_data.temparature
  #  get order_cars_path
  #  expect(response).to have_content("#{forecast_data.temparature}")
  #  expect(response).to have_content("#{forecast_data.description}")
  #   expect(response.body).to have_content("#{@forecast_data.icon}")
  #end
end