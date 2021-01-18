require 'rails_helper'

describe "Map Quest Service Api" do
  it "returns latitue and longitute of a given location" do
    VCR.use_cassette('map_quest_api_call') do
      location = 'denver,co'
      coordinates = MapQuestService.fetch_coordiantes(location)

      expect(coordinates).to be_a(Hash)
      expect(coordinates[:lat].class).to eq(Float)
      expect(coordinates[:lng].class).to eq(Float)
    end
  end

  it "fetch_route returns the route travel time" do
    VCR.use_cassette("map_quest_api_route_success") do
      trip_info = {origin: "Denver,CO", destination: "Pueblo,CO"}

      route = MapQuestService.fetch_route(trip_info)

      expect(route).to be_a(Hash)
      expect(route[:route]).to be_a(Hash)
      expect(route[:route].has_key?(:realTime)).to eq(true)
      expect(route[:route][:realTime]).to be_a(Integer)
    end
  end
end
