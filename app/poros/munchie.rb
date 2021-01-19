class Munchie < RoadTrip
  attr_reader :destination_city, :travel_time, :forecast, :restaurant
  def initialize(destination, route_info, destination_weather, restaurant)
    @destination_city = destination
    @travel_time = format_travel_time(route_info[:route][:realTime])
    @forecast = format_forecast(destination_weather[:current])
    @restaurant = format_restaurant(restaurant)
  end

  def format_forecast(weather)
    {
      summary: weather[:weather][0][:description],
      temperature: weather[:temp]
    }
  end

  def format_restaurant(restaurant)
    {
      name: restaurant[:name],
      address: restaurant[:location][:display_address].join(', ')
    }
  end
end
