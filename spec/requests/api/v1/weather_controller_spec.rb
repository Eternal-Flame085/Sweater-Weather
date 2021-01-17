require 'rails_helper'

describe "Weather api" do
  it "returns a sesialized json" do
    VCR.use_cassette('open_weather_api_call') do
      VCR.use_cassette('map_quest_api_call') do
        location = "denver,co"

        get "/api/v1/forecast?location=#{location}"
        expect(response).to be_successful

        weather = JSON.parse(response.body, symbolize_names: true)

        expect(weather).to be_a(Hash)
        expect(weather[:data]).to be_a(Hash)
        expect(weather[:data][:type]).to be_a(String)
        expect(weather[:data][:type]).to eq("forecast")
        expect(weather[:data][:attributes]).to be_a(Hash)

        attribute_keys = [:current_weather, :daily_weather, :hourly_weather]
        expect(weather[:data][:attributes].keys).to eq(attribute_keys)
        expect(weather[:data][:attributes]).to be_a(Hash)
        expect(weather[:data][:attributes][:current_weather]).to be_a(Hash)

        expect(weather[:data][:attributes][:daily_weather]).to be_a(Array)
        expect(weather[:data][:attributes][:daily_weather].count).to eq(5)
        expect(weather[:data][:attributes][:daily_weather].first).to be_a(Hash)

        expect(weather[:data][:attributes][:hourly_weather]).to be_a(Array)
        expect(weather[:data][:attributes][:hourly_weather].count).to eq(8)
        expect(weather[:data][:attributes][:hourly_weather].first).to be_a(Hash)
      end
    end
  end
end
