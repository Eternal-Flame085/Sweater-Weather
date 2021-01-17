require 'rails_helper'

describe WeatherSearchFacade do
  it "returns a weather poro after calling the api services" do
    VCR.use_cassette('open_weather_api_call') do
      VCR.use_cassette('map_quest_api_call') do
        denver = "denver,co"
        weather = WeatherSearchFacade.find_weather(denver)

        expect(weather).to be_a(Forecast)
        expect(weather.current_weather).to be_a(Hash)

        expect(weather.daily_weather).to be_a(Array)
        expect(weather.daily_weather.first).to be_a(Hash)
        expect(weather.daily_weather.count).to eq(5)

        expect(weather.hourly_weather).to be_a(Array)
        expect(weather.hourly_weather.first).to be_a(Hash)
        expect(weather.hourly_weather.count).to eq(8)
      end
    end
  end
end
