class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(trip_info, road_trip_time,weather_data)
    @start_city = trip_info[:origin]
    @end_city = trip_info[:destination]
    @travel_time = format_travel_time(road_trip_time)
    @weather_at_eta = format_weather(road_trip_time, weather_data)
  end

  def format_weather(road_trip_time, weather_data)
    return {} if weather_data.nil?
    weather_data[:hourly].each do |hour|
      if Time.at(hour[:dt]).utc.strftime('%I') == Time.at(weather_data[:current][:dt]).utc.strftime('%I')
        weather_at_eta = weather_data[:hourly][ weather_data[:hourly].index(hour) + (road_trip_time / 3600) ]
        break {temperature: weather_at_eta[:temp], conditions: weather_at_eta[:weather][0][:description]}
      end
    end
  end

  def format_travel_time(road_trip_time)
    if !road_trip_time.nil?
      "#{road_trip_time / 3600}h #{road_trip_time / 60 % 60}m"
    else
      "Impossible Route"
    end
  end
end
