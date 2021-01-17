class OpenWeatherService
  class << self
    def fetch_location_weather(coordinates)
      response = conn.get("/data/2.5/onecall?") do |req|
        req.params[:lat] = coordinates[:lat]
        req.params[:lon] = coordinates[:lng]
        req.params[:units] = 'imperial'
        req.params[:exclude] = 'minutely, alerts'
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      Faraday.new(url: 'https://api.openweathermap.org') do |faraday|
        faraday.params[:appid] = ENV['OPEN_WEATHER']
      end
    end
  end
end
