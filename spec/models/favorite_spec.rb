require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "Relationships" do
    it { should belong_to :user }
  end

  describe "Validations" do
    it { should validate_presence_of :country }
    it { should validate_presence_of :recipe_title }
    it { should validate_presence_of :recipe_link }
  end
end
