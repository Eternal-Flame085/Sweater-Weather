require 'rails_helper'

describe "trips controller" do
  it "returns a serialized road trip poro if there is a possible route and valid api key is given" do
    VCR.use_cassette('map_quest_api_denver_pueblo') do
      VCR.use_cassette('pueblo_co_coords') do
        VCR.use_cassette('pueblo_weather_data') do

          get "/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese"

          expect(response).to be_successful
          expect(response.status).to eq(201)
          munchies = JSON.parse(response.body, symbolize_names: true)

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
  end
end
