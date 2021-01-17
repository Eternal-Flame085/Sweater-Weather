require 'rails_helper'

describe Background do
  before :each do
    VCR.use_cassette('pexels_image_search') do
      location = 'Miami,Fl'
      images = PexelsService.find_images(location)
      @background = Background.new(location,images[:photos].sample)
    end
  end

  it "image is readable and has valus" do
    expect(@background.image).to be_a(Hash)
    expect(@background.image.keys).to eq([:location, :image_url])
    expect(@background.image[:location]).to be_a(String)
    expect(@background.image[:image_url]).to be_a(String)
  end

  it "credit is readable and has values" do
    credit_keys = [:source, :logo, :image_source_url, :author, :author_url]
    expect(@background.credit).to be_a(Hash)
    expect(@background.credit.keys).to eq(credit_keys)
    expect(@background.credit[:source]).to be_a(String)
    expect(@background.credit[:logo]).to be_a(String)
    expect(@background.credit[:image_source_url]).to be_a(String)
    expect(@background.credit[:author]).to be_a(String)
    expect(@background.credit[:author_url]).to be_a(String)
  end
end
