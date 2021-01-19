class MunchiesFacade
  class << self
    def find_food_for_destination(munchies_route_info)
      munchies_trip_route = MapQuestService.fetch_route()
    end
  end
end
