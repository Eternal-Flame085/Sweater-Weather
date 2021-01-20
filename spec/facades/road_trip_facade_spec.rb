require 'rails_helper'

describe RoadTripFacade do
  it "fetch_road_trip_info returns a roadtrip poro" do
    VCR.use_cassette("trips") do
      trip_info = {origin: "Denver,CO", destination: "Pueblo,CO"}
      road_trip = RoadTripFacade.fetch_road_trip_info(trip_info, 'imperial')

      expect(road_trip).to be_a(RoadTrip)
    end
  end
end
