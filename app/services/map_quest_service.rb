class MapQuestService
  class << self
    def fetch_coordiantes(location)
      response = conn.get("/geocoding/v1/address?") do |map_quest|
        map_quest.params[:location] = location
      end

      data = JSON.parse(response.body, symbolize_names: true)
      
      data[:results][0][:locations][0][:latLng]
    end

    private

    def conn
      Faraday.new(url: 'http://www.mapquestapi.com') do |faraday|
        faraday.params[:key] = ENV['MAP_QUEST']
      end
    end
  end
end
