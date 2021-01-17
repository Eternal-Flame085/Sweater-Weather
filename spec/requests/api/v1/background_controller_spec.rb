require 'rails_helper'

describe 'returning a background for location' do
  it "Returns a json response about the image and credits" do
    VCR.use_cassette('pexels_image_search') do
      location = 'Miami,Fl'
      get "/api/v1/backgrounds?location=#{location}"
      expect(response).to be_successful

      background = JSON.parse(response.body, symbolize_names: true)

      expect(background[:data]).to be_a(Hash)
      expect(background[:data][:type]).to be_a(String)
      expect(background[:data][:type]).to eq('image')
      expect(background[:data][:attributes]).to be_a(Hash)
      expect(background[:data][:attributes].keys).to eq([:image, :credit])

      expect(background[:data][:attributes][:image]).to be_a(Hash)
      expect(background[:data][:attributes][:image].keys).to eq([:location, :image_url])
      expect(background[:data][:attributes][:image][:location]).to be_a(String)
      expect(background[:data][:attributes][:image][:image_url]).to be_a(String)

      credit_keys = [:source, :logo, :image_source_url, :author, :author_url]
      expect(background[:data][:attributes][:credit]).to be_a(Hash)
      expect(background[:data][:attributes][:credit].keys).to eq(credit_keys)
      expect(background[:data][:attributes][:credit][:source]).to be_a(String)
      expect(background[:data][:attributes][:credit][:logo]).to be_a(String)
      expect(background[:data][:attributes][:credit][:image_source_url]).to be_a(String)
      expect(background[:data][:attributes][:credit][:author]).to be_a(String)
      expect(background[:data][:attributes][:credit][:author_url]).to be_a(String)

    end
  end
end
