class Background
  attr_reader :image, :credit
  def initialize(location, image)
    @image = {location: location, image_url: image[:src][:original]}
    @credit = format_credit(image)
  end

  def format_credit(image)
    {
      source: 'https://www.pexels.com',
      logo: 'https://images.pexels.com/lib/api/pexels-white.png',
      image_source_url: image[:url],
      author: image[:photographer],
      author_url: image[:photographer_url]
    }
  end
end
