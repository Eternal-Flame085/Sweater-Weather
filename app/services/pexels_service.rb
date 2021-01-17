class PexelsService
  class << self
    def find_images(location)
      response = conn.get('/v1/search?') do |req|
        req.params[:query] = location
        req.params[:orientation] = 'landscape'
        req.params[:per_page] = 5
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      Faraday.new(url: 'https://api.pexels.com') do |faraday|
        faraday.headers[:Authorization] = ENV['PEXELS']
      end
    end
  end
end
