require 'rails_helper'

describe BackgroundFacade do
  it "Returns an Image poro object" do
    VCR.use_cassette('pexels_image_search') do
      image = BackgroundFacade.find_image('Miami,Fl')

      expect(image).to be_a(Background)
    end
  end
end
