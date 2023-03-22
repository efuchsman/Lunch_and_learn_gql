class RestCountriesService
  def self.conn
    Faraday.new("https://restcountries.com")
  end

  def self.all_countries
    response = conn.get("/v3.1/all?fields=name,capital")
    JSON.parse(response.body, symbolize_names: true)
  end
end
