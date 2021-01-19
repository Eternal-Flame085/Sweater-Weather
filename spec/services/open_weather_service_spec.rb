require 'rails_helper'

describe "Open Weather Service Api" do
  it "returns weathher data for given coordinates" do
    VCR.use_cassette('open_weather_api_call') do
      denver_coords = {lat: 39.738453, lng: -104.984853}
      weather_data = OpenWeatherService.fetch_location_weather(denver_coords, 'imperial')

      #Current Weather
      expect(weather_data[:current]).to be_a(Hash)
      expect(weather_data[:current][:dt]).to be_a(Integer)
      expect(weather_data[:current][:sunrise]).to be_a(Integer)
      expect(weather_data[:current][:sunset]).to be_a(Integer)
      expect(weather_data[:current][:temp]).to be_a(Float)
      expect(weather_data[:current][:feels_like]).to be_a(Float)
      expect(weather_data[:current][:humidity]).to be_a_kind_of(Numeric)
      expect(weather_data[:current][:uvi]).to be_a_kind_of(Numeric)
      expect(weather_data[:current][:visibility]).to be_a_kind_of(Numeric)
      expect(weather_data[:current][:weather][0][:description]).to be_a(String)
      expect(weather_data[:current][:weather][0][:icon]).to be_a(String)

      #Daily Weather
      expect(weather_data[:daily]).to be_a(Array)
      expect(weather_data[:daily].first).to be_a(Hash)
      expect(weather_data[:daily].last).to be_a(Hash)
      expect(weather_data[:daily][0][:dt]).to be_a(Integer)
      expect(weather_data[:daily][0][:sunrise]).to be_a(Integer)
      expect(weather_data[:daily][0][:sunset]).to be_a(Integer)
      expect(weather_data[:daily][0][:temp]).to be_a(Hash)
      expect(weather_data[:daily][0][:temp][:max]).to be_a(Float)
      expect(weather_data[:daily][0][:temp][:min]).to be_a(Float)
      expect(weather_data[:daily][0][:weather][0][:description]).to be_a(String)
      expect(weather_data[:daily][0][:weather][0][:icon]).to be_a(String)

      #Hourly Weather
      expect(weather_data[:hourly]).to be_a(Array)
      expect(weather_data[:hourly].first).to be_a(Hash)
      expect(weather_data[:hourly].last).to be_a(Hash)
      expect(weather_data[:hourly][0][:dt]).to be_a(Integer)
      expect(weather_data[:hourly][0][:temp]).to be_a(Float)
      expect(weather_data[:hourly][0][:wind_speed]).to be_a(Float)
      expect(weather_data[:hourly][0][:wind_deg]).to be_a(Integer)
      expect(weather_data[:hourly][0][:weather][0][:description]).to be_a(String)
      expect(weather_data[:hourly][0][:weather][0][:icon]).to be_a(String)
   end
  end
end
