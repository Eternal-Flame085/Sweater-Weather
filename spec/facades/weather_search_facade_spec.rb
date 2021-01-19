require 'rails_helper'

describe WeatherSearchFacade do
  it "returns a weather poro after calling the api services" do
    VCR.use_cassette('open_weather_api_call') do
      VCR.use_cassette('map_quest_api_call') do
        denver = "denver,co"
        weather = WeatherSearchFacade.find_weather(denver, 'imperial')

        expect(weather).to be_a(Forecast)
      end
    end
  end
end
