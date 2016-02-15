require 'weather_forecast'

class WeatherDatasController < ApplicationController
  def create
    forecast = WeatherForecast.new
    @forecast_data = forecast.show
    render order_cars_path
  end 
end  