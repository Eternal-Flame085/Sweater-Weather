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
end
