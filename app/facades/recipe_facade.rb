class RecipeFacade

  def self.recipes_by_country(country)
    if EdamamService.recipes_by_country(country)[:status] == "error"
      "Usage limits are exceeded"
    else
      EdamamService.recipes_by_country(country)[:hits].map do | recipe |
        Recipe.new(recipe, country)
      end
    end
  end
end
