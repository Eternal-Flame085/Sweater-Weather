class MunchiesFacade
  class << self
    def find_food_for_destination(munchies_route_info)
      route =  {origin: munchies_route_info['start'], destination: munchies_route_info['end']}
      munchies_trip_route = MapQuestService.fetch_route(route)
      destination_coords = MapQuestService.fetch_coordiantes(route[:destination])
      destination_weather = OpenWeatherService.fetch_location_weather(destination_coords)
      time_of_arrival = destination_weather[:current][:dt] + munchies_trip_route[:route][:realTime]
      restaurant = YelpService.find_restaurant(route[:destination], munchies_route_info['food'], time_of_arrival)
      require "pry"; binding.pry
    end
  end
end
