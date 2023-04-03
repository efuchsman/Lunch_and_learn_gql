require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Relationships" do
    it { should have_many :favorites }
  end

  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe "Instance Methods" do

    let!(:user) { User.create(name: "Athena Dao", email: "athenadao@bestgirlever.com") }

    describe "#construct_api_key" do
      it "creates an api key for the user" do

        expect(user.construct_api_key).to be_a String
        expect(user.construct_api_key.chars.length).to eq(32)
      end
    end
  end
end
