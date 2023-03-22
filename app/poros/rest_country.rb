class RestCountry

  attr_reader :name,
              :capital

  def initialize(data)
    @name = data[:name][:common]
    @capital = data[:capital][0]
  end
end
