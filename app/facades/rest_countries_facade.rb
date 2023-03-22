class RestCountriesFacade

  def self.all_countries
    RestCountriesService.all_countries.map do | country |
      RestCountry.new(country)
    end
  end

  def self.random_country
    self.all_countries.sample
  end
end
