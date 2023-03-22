require 'rails_helper'

RSpec.describe RestCountry do
  it 'exists and has attributes' do

    data = {
      name: {
        official: "Grenada"
      },
      capital: ["St. George's"]
    }

    grenada = RestCountry.new(data)
    expect(grenada).to be_a RestCountry
  end
end
