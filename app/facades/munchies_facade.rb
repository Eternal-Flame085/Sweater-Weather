class MunchiesFacade
  class << self
    def find_food_for_destination(munchies_route_info)
      require "pry"; binding.pry
      route =  {origin: munchies_route_info[:start], destination: munchies_route_info[:end]}
      munchies_trip_route = MapQuestService.fetch_route(route)
      require "pry"; binding.pry
    end
  end
end
