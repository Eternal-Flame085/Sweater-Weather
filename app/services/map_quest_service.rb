class MapQuestService
  class << self
    def fetch_coordiantes(location)
      response = conn.get("/geocoding/v1/address?") do |map_quest|
        map_quest.params[:location] = location
      end

      data = JSON.parse(response.body, symbolize_names: true)

      data[:results][0][:locations][0][:latLng]
    end

    def fetch_route(trip_info)
      response = conn.get("/directions/v2/route") do |map_quest|
        map_quest.params[:from] = trip_info[:origin]
        map_quest.params[:to] = trip_info[:destination]
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      Faraday.new(url: 'http://www.mapquestapi.com') do |faraday|
        faraday.params[:key] = ENV['MAP_QUEST']
      end
    end
  end
end
