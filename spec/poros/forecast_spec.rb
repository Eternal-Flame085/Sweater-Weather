require 'rails_helper'

describe Forecast do
  before :each do
    VCR.use_cassette('open_weather_api_call') do
      denver_coords = {lat: 39.738453, lng: -104.984853}
      weather_data = OpenWeatherService.fetch_location_weather(denver_coords, 'imperial')

      @weather_poro = Forecast.new(weather_data)
    end
  end

  it "Creates a poro with a current_weather variable" do
    current_weather_keys = [:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon]
      expect(@weather_poro.current_weather).to be_a(Hash)
      expect(@weather_poro.current_weather.keys).to eq(current_weather_keys)
      expect(@weather_poro.current_weather[:datetime]).to be_a(Time)
      expect(@weather_poro.current_weather[:sunrise]).to be_a(Time)
      expect(@weather_poro.current_weather[:sunset]).to be_a(Time)
      expect(@weather_poro.current_weather[:temperature]).to be_a(Float)
      expect(@weather_poro.current_weather[:feels_like]).to be_a(Float)
      expect(@weather_poro.current_weather[:humidity]).to be_a_kind_of(Numeric)
      expect(@weather_poro.current_weather[:uvi]).to be_a_kind_of(Numeric)
      expect(@weather_poro.current_weather[:visibility]).to be_a_kind_of(Numeric)
      expect(@weather_poro.current_weather[:conditions]).to be_a(String)
      expect(@weather_poro.current_weather[:icon]).to be_a(String)
  end

  it "Creates a poro with a daily_weather variable" do
    daily_weather_keys = [:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon]

    expect(@weather_poro.daily_weather).to be_a(Array)
    expect(@weather_poro.daily_weather.count).to eq(5)
    expect(@weather_poro.daily_weather.first).to be_a(Hash)
    expect(@weather_poro.daily_weather.last).to be_a(Hash)
    expect(@weather_poro.daily_weather[0].keys).to eq(daily_weather_keys)
    expect(@weather_poro.daily_weather[0][:date]).to be_a(String)
    expect(@weather_poro.daily_weather[0][:sunrise]).to be_a(Time)
    expect(@weather_poro.daily_weather[0][:sunset]).to be_a(Time)
    expect(@weather_poro.daily_weather[0][:max_temp]).to be_a(Float)
    expect(@weather_poro.daily_weather[0][:min_temp]).to be_a(Float)
    expect(@weather_poro.daily_weather[0][:conditions]).to be_a(String)
    expect(@weather_poro.daily_weather[0][:icon]).to be_a(String)
  end

  it "Creates a poro with a hourly_weather variable" do
    hourly_weather_keys = [:time, :temperature, :wind_speed, :wind_direction, :conditions, :icon]

    expect(@weather_poro.hourly_weather).to be_a(Array)
    expect(@weather_poro.hourly_weather.count).to eq(8)
    expect(@weather_poro.hourly_weather.first).to be_a(Hash)
    expect(@weather_poro.hourly_weather.last).to be_a(Hash)
    expect(@weather_poro.hourly_weather[0].keys).to eq(hourly_weather_keys)
    expect(@weather_poro.hourly_weather[0][:time]).to be_a(String)
    expect(@weather_poro.hourly_weather[0][:temperature]).to be_a(Float)
    expect(@weather_poro.hourly_weather[0][:wind_speed]).to be_a(String)
    expect(@weather_poro.hourly_weather[0][:wind_direction]).to be_a(String)
    expect(@weather_poro.hourly_weather[0][:conditions]).to be_a(String)
    expect(@weather_poro.hourly_weather[0][:icon]).to be_a(String)
  end
  it "Created a poro with the units as imperial" do
    expect(@weather_poro.current_weather[:temperature]).to eq(42.82)
  end

  it "Created a poro with the units as metric" do
    VCR.use_cassette('open_weather_api_call_metric') do
      denver_coords = {lat: 39.738453, lng: -104.984853}
      weather_data = OpenWeatherService.fetch_location_weather(denver_coords, 'metric')

      weather_poro = Forecast.new(weather_data)
      expect(weather_poro.current_weather[:temperature]).to eq(0.44)
    end
  end
end
