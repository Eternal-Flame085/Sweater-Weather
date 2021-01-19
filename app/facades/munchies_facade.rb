class MunchiesFacade
  class << self
    def find_food_for_destination(munchies_route_info)
      route =  {origin: munchies_route_info['start'], destination: munchies_route_info['end']}
      munchies_trip_route = MapQuestService.fetch_route(route)
      destination_coords = MapQuestService.fetch_coordiantes(trip_info[:destination])
      destination_weather = OpenWeatherService.fetch_location_weather(destination_coords)
      restaurant = YelpService.find_restaurant(munchies_route_info['end'], munchies_route_info['food'])
      require "pry"; binding.pry
    end
  end
end
