require 'rails_helper'

describe RoadTrip do
  it "Can be created and variables have values" do
    VCR.use_cassette("trips") do
      trip_info = {origin: "Denver,CO", destination: "Pueblo,CO"}
      road_trip_route = MapQuestService.fetch_route(trip_info)
      destination_coords = MapQuestService.fetch_coordiantes(trip_info[:destination])
      destination_weather = OpenWeatherService.fetch_location_weather(destination_coords, 'imperial')
      road_trip = RoadTrip.new(trip_info, road_trip_route[:route][:realTime], destination_weather)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.start_city).to be_a(String)
      expect(road_trip.end_city).to be_a(String)
      expect(road_trip.travel_time).to be_a(String)

      expect(road_trip.weather_at_eta).to be_a(Hash)
      expect(road_trip.weather_at_eta.keys).to eq([:temperature, :conditions])
      expect(road_trip.weather_at_eta[:temperature]).to be_a(Numeric)
      expect(road_trip.weather_at_eta[:conditions]).to be_a(String)
    end
  end

  it "Gets created with an impossible route as the travel time" do
    VCR.use_cassette('map_quest_api_route_unsuccessful') do
      trip_info = {origin: "Denver,CO", destination: "London,UK"}
      road_trip_route = MapQuestService.fetch_route(trip_info)
      destination_weather = nil
      road_trip = RoadTrip.new(trip_info, road_trip_route[:route][:realTime], destination_weather)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.start_city).to be_a(String)
      expect(road_trip.start_city).to eq("Denver,CO")
      expect(road_trip.end_city).to be_a(String)
      expect(road_trip.end_city).to eq("London,UK")

      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.travel_time).to eq("Impossible Route")

      expect(road_trip.weather_at_eta).to be_a(Hash)
      expect(road_trip.weather_at_eta).to eq({})
    end
  end
end
