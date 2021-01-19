class Api::V1::WeatherController < ApplicationController
  def index
    units = 'imperial'
    units = params[:units] if !params[:units].nil?
    render json: ForecastSerializer.new(WeatherSearchFacade.find_weather(params[:location], units))
  end
end
