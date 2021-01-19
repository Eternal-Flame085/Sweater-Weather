require 'rails_helper'

describe RoadTripFacade do
  it "fetch_road_trip_info returns a roadtrip poro" do
    VCR.use_cassette("map_quest_api_route_success") do
      VCR.use_cassette("pueblo_co_coords") do
        VCR.use_cassette("pueblo_weather_data") do
          trip_info = {origin: "Denver,CO", destination: "Pueblo,CO"}
          road_trip = RoadTripFacade.fetch_road_trip_info(trip_info, 'imperial')

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
    end
  end

  it "fetch_road_trip_info returns a roadtrip poro with an impossible route error" do
    VCR.use_cassette('map_quest_api_route_unsuccessful') do
      trip_info = {origin: "Denver,CO", destination: "London,UK"}
      road_trip = RoadTripFacade.fetch_road_trip_info(trip_info, 'imperial')

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
