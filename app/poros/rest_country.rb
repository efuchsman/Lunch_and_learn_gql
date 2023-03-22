class RestCountry

  attr_reader :name,
              :capital

  def initialize(data)
    @name = data[:name][:official]
    @capital = data[:capital][0]
  end
end
