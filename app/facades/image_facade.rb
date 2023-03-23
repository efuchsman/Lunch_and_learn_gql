class ImageFacade

  def self.country_images(country)
    UnsplashService.country_images(country)[:results].map do | image |
      Image.new(image)
    end
  end
end
