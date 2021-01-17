class Api::V1::WeatherController < ApplicationController
  def index
    render json: ForecastSerializer.new(WeatherSearchFacade.find_weather(params[:location]))
  end
end
