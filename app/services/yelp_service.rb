class YelpService
  class << self
    def find_restaurant(destination, food, time_of_arrival)
      response = conn.get("/v3/businesses/search?") do |yelp|
        yelp.params[:location] = destination
        yelp.params[:term] = food
        yelp.params[:open_at] = time_of_arrival
      end

      restaurants = JSON.parse(response.body, symbolize_names: true)
      restaurants[:businesses].first
    end

    def conn
      Faraday.new(url: 'https://api.yelp.com') do |faraday|
        faraday.headers[:Authorization] = ENV['YELP_FUSION']
      end
    end
  end
end
