class WeatherSearchFacade
  class << self
    def find_weather(location)
      coordinates = MapQuestService.fetch_coordiantes(location)
      Forecast.new(OpenWeatherService.fetch_location_weather(coordinates))
    end
  end
end
