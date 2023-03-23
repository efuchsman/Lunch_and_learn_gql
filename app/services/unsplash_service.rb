class UnsplashService

  def self.conn
    Faraday.new("https://api.unsplash.com/")
  end

  def self.country_images(country)
    response = conn.get("search/photos?client_id=#{ENV['unsplash_access_key']}&query=#{country}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
