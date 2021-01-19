require 'rails_helper'

describe MunchiesFacade do
  it "returns a poro object" do
    VCR.use_cassette('munchies') do
      munchies_route_info = {"start"=>"denver,co", "end"=>"pueblo,co", "food"=>"chinese"}
      munchies = MunchiesFacade.find_food_for_destination(munchies_route_info)

      expect(munchies).to be_a(Munchie)
      expect(munchies.destination_city).to be_a(String)
      expect(munchies.travel_time).to be_a(String)
      expect(munchies.forecast).to be_a(Hash)
      expect(munchies.forecast.keys).to eq([:summary, :temperature])
      expect(munchies.forecast[:summary]).to be_a(String)
      expect(munchies.forecast[:temperature]).to be_a(Numeric)

      expect(munchies.restaurant).to be_a(Hash)
      expect(munchies.restaurant.keys).to eq([:name, :address])
      expect(munchies.restaurant[:name]).to be_a(String)
      expect(munchies.restaurant[:address]).to be_a(String)
    end
  end
end
