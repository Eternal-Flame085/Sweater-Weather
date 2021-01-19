class WeatherSearchFacade
  class << self
    def find_weather(location, units)
      coordinates = MapQuestService.fetch_coordiantes(location)
      Forecast.new(OpenWeatherService.fetch_location_weather(coordinates,units))
    end
  end
end
