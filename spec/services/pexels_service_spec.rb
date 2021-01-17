require 'rails_helper'

describe PexelsService do
  it "Returns images related to the location given with required information" do
    VCR.use_cassette('pexels_image_search') do
      images = PexelsService.find_images("Miami,Fl")

      expect(images).to be_a(Hash)
      expect(images.has_key?(:photos)).to eq(true)
      expect(images[:photos]).to be_a(Array)
      expect(images[:photos][0][:photographer]).to be_a(String)
      expect(images[:photos][0][:photographer_url]).to be_a(String)
      expect(images[:photos][0][:url]).to be_a(String)
      expect(images[:photos][0][:src]).to be_a(Hash)
      expect(images[:photos][0][:src][:original]).to be_a(String)
    end
  end
end
