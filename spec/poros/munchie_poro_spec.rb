require 'rails_helper'

describe Munchie do
  it "Poro is created and variables have values" do
    VCR.use_cassette('munchies') do
      route =  {origin: 'denver,co', destination: 'pueblo,co'}

      munchies_trip_route = MapQuestService.fetch_route(route)
      destination_coords = MapQuestService.fetch_coordiantes(route[:destination])
      destination_weather = OpenWeatherService.fetch_location_weather(destination_coords)

      time_of_arrival = destination_weather[:current][:dt] + munchies_trip_route[:route][:realTime]
      restaurant = YelpService.find_restaurant(route[:destination], munchies_route_info['food'], time_of_arrival)

      poro = Munchie.new(route[:destination], destination_weather, restaurant)

      expect(poro).to be_a(Hash)
      expect(poro.destination_city).to be_a(String)
      expect(poro.travel_time).to be_a(String)
      expect(poro.forecast).to be_a(Hash)
      expect(poro.forecast.keys).to eq([:summary, :temperature])
      expect(poro.forecast[:conditions]).to be_a(String)
      expect(poro.forecast[:temperature]).to be_a(String)

      expect(poro.restaurant).to be_a(Hash)
      expect(poro.restaurant.keys).to eq([:name, :address])
      expect(poro.restaurant[:name]).to be_a(String)
      expect(poro.restaurant[:address]).to be_a(Sring)
    end
  end
end
