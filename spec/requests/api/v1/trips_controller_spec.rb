require 'rails_helper'

describe "trips controller" do
  it "returns a serialized road trip poro if there is a possible route and valid api key is given" do
    VCR.use_cassette("trips") do
      user = User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")

      trip_info = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": user.api_key
      }

      post "/api/v1/road_trip", params: trip_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(201)
      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip).to be_a(Hash)
      expect(road_trip[:data]).to be_a(Hash)
      expect(road_trip[:data].keys).to eq([:id, :type, :attributes])
      expect(road_trip[:data][:type]).to eq("roadtrip")
      expect(road_trip[:data][:attributes]).to be_a(Hash)

      expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(road_trip[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
      expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)
      expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
  end

  it "returns a serialized road trip poro with an impossible route" do
    VCR.use_cassette("map_quest_api_route_unsuccessful") do
      user = User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")

      trip_info = {
        "origin": "Denver,CO",
        "destination": "London,UK",
        "api_key": user.api_key
      }

      post "/api/v1/road_trip", params: trip_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(201)
      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip).to be_a(Hash)
      expect(road_trip[:data]).to be_a(Hash)
      expect(road_trip[:data].keys).to eq([:id, :type, :attributes])
      expect(road_trip[:data][:type]).to eq("roadtrip")
      expect(road_trip[:data][:attributes]).to be_a(Hash)

      expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
      expect(road_trip[:data][:attributes][:travel_time]).to eq("Impossible Route")
      expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to eq({})
    end
  end

  it "returns an Unauthorized error if no api key is given" do
    trip_info = {
      "origin": "Denver,CO",
      "destination": "London,UK",
      "api_key": ""
    }

    post "/api/v1/road_trip", params: trip_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:errors]).to eq("Unauthorized")
  end

  it "returns an Unauthorized error if api key does not match a user" do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")

    trip_info = {
      "origin": "Denver,CO",
      "destination": "London,UK",
      "api_key": "buidfbv78b3ubf937"
    }

    post "/api/v1/road_trip", params: trip_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:errors]).to eq("Unauthorized")
  end
end
