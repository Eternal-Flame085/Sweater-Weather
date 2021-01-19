class RoadTripFacade
  class << self
    def fetch_road_trip_info(trip_info, units)
      road_trip_route = MapQuestService.fetch_route(trip_info)
      destination_coords = nil
      destination_weather = nil

      if road_trip_route[:info][:statuscode] != 402
        destination_coords = MapQuestService.fetch_coordiantes(trip_info[:destination])
        destination_weather = OpenWeatherService.fetch_location_weather(destination_coords, units)
      end

      RoadTrip.new(trip_info, road_trip_route[:route][:realTime], destination_weather)
    end
  end
end
