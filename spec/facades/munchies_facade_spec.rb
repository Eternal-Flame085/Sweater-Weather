require 'rails_helper'

describe MunchiesFacade do
  it "returns a poro object" do
    VCR.use_cassette('map_quest_api_denver_pueblo') do
      munchies_route_info = {"start"=>"denver,co", "end"=>"pueblo,co", "food"=>"chinese"}
      munchies = MunchiesFacade.find_food_for_destination(munchies_route_info)

      require "pry"; binding.pry
      expect(munchies).to be_a(Hash)
      expect(munchies[:data]).to be_a(Hash)
      expect(munchies[:data].keys).to eq([:id, :type, :attributes, :restaurant])
      expect(munchies[:data][:type]).to eq("munchies")
      expect(munchies[:data][:attributes]).to be_a(Hash)

      expect(munchies[:data][:attributes][:destination_city]).to be_a(String)
      expect(munchies[:data][:attributes][:travel_time]).to be_a(String)
      expect(munchies[:data][:attributes][:forecast]).to be_a(Hash)
      expect(munchies[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(munchies[:data][:attributes][:forecast][:conditions]).to be_a(String)
      expect(munchies[:data][:attributes][:forecast][:temperature]).to be_a(String)

      expect(munchies[:data][:restaurant].keys).to eq([:name, :address])
      expect(munchies[:data][:restaurant][:name]).to be_a(String)
      expect(munchies[:data][:restaurant][:address]).to be_a(String)
    end
  end
end
