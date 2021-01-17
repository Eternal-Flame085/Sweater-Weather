class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(weather_data)
    @current_weather = format_current_weather(weather_data[:current])
    @daily_weather = format_daily_weather(weather_data[:daily])
    @hourly_weather = format_hourly_weather(weather_data[:hourly])
  end

  def format_current_weather(current_weather_data)
    {
      datetime: Time.at(current_weather_data[:dt]),
      sunrise: Time.at(current_weather_data[:sunrise]),
      sunset: Time.at(current_weather_data[:sunrise]),
      temperature: current_weather_data[:temp],
      feels_like: current_weather_data[:feels_like],
      humidity: current_weather_data[:humidity],
      uvi: current_weather_data[:uvi],
      visibility: current_weather_data[:visibility],
      conditions: current_weather_data[:weather][0][:description],
      icon: current_weather_data[:weather][0][:icon]
    }
  end

  def format_daily_weather(daily_weather_data)
    daily_weather_data[1..5].map do |day|
      {
        date: Time.at(day[:dt]).strftime('%Y-%m-%d'),
        sunrise:  Time.at(day[:sunrise]),
        sunset:  Time.at(day[:sunset]),
        max_temp: day[:temp][:max],
        min_temp: day[:temp][:min],
        conditions: day[:weather][0][:description],
        icon: day[:weather][0][:icon]
      }
    end
  end

  def format_hourly_weather(hourly_weather_data)
    wind_directions = ["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
    hourly_weather_data[0..7].map do |hour|
      {
        time: Time.at(hour[:dt]).strftime("%k:%M:%S"),
        temperature: hour[:temp],
        wind_speed: "#{hour[:wind_speed]} mph",
        wind_direction: wind_directions[((hour[:wind_deg]/22.5)+0.5) %16],
        conditions: hour[:weather][0][:description],
        icon: hour[:weather][0][:icon]
      }
    end
  end
end
