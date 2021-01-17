require 'rails_helper'

describe BackgroundFacade do
  it "Returns an Image poro object" do
    VCR.use_cassette('pexels_image_search') do
        image = BackgroundFacade.find_image('Miami,Fl')

        expect(image).to be_a(Background)

        expect(image.image).to be_a(Hash)
        expect(image.image.keys).to eq([:location, :image_url])
        expect(image.image[:location]).to be_a(String)
        expect(image.image[:image_url]).to be_a(String)

        credit_keys = [:source, :logo, :image_source_url, :author, :author_url]
        expect(image.credit).to be_a(Hash)
        expect(image.credit.keys).to eq(credit_keys)
        expect(image.credit[:source]).to be_a(String)
        expect(image.credit[:logo]).to be_a(String)
        expect(image.credit[:image_source_url]).to be_a(String)
        expect(image.credit[:author]).to be_a(String)
        expect(image.credit[:author_url]).to be_a(String)
    end
  end
end
