require 'rails_helper'

describe YelpService do
  it "returns a restaurant at the destination" do
    VCR.use_cassette('yelp_chinese_request') do
      destination = 'pueblo,co'
      food = 'chinese'
      time_of_arrival = 1611083482

      restaurant = YelpService.find_restaurant(destination, food, time_of_arrival)

      expect(restaurant).to be_a(Hash)
      expect(restaurant.has_key?(:name)).to eq(true)
      expect(restaurant[:name]).to be_a(String)
      expect(restaurant.has_key?(:location)).to eq(true)
      expect(restaurant[:location]).to be_a(Hash)
      expect(restaurant[:location].has_key?(:display_address)).to eq(true)
      expect(restaurant[:location][:display_address]).to be_a(Array)
      expect(restaurant[:location][:display_address][0]).to be_a(String)
    end
  end
end
