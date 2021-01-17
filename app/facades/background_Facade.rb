class BackgroundFacade
  class << self
    def find_image(location)
      images = PexelsService.find_images(location)
      Background.new(location, images[:photos].sample)
    end
  end
end
