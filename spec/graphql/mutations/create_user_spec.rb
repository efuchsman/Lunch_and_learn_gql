require 'rails_helper'

RSpec.describe Mutations::CreateUser, type: :request do
  describe "creating a new user" do
    before :each do
      @query1 =
          <<~GQL
            mutation {
              createUser(input: {params: { name: "Eli Fuchsman", email: "elif@mail.com"}}){
                user {
                  id
                  name
                  email
                  apiKey
                }
              }
            }
          GQL

    end

    describe "When parameters and validations are met" do
      it "creates a new user", :vcr do
        result = LunchAndLearnGqlSchema.execute(@query1).to_json
        json = JSON.parse(result, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :data
        expect(json[:data]).to be_a Hash
        expect(json[:data]).to have_key :createUser
        expect(json[:data][:createUser]).to have_key :user
        expect(json[:data][:createUser][:user].keys).to eq([:id, :name, :email, :apiKey])
      end
    end

    describe "When an email is already taken" do
      it "returns an error", :vcr do
        query2 =
          <<~GQL
            mutation {
              createUser(input: {params: { name: "Eli Fuchsman", email: "elif@mail.com"}}){
                user {
                  id
                  name
                  email
                  apiKey
                }
              }
            }
          GQL

        result1 = LunchAndLearnGqlSchema.execute(@query1).to_json
        result2 = LunchAndLearnGqlSchema.execute(query2).to_json
        json = JSON.parse(result2, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :data
        expect(json[:data]).to be_a Hash
        expect(json[:data]).to have_key :createUser
        expect(json[:data][:createUser]).to be nil
        expect(json).to have_key :errors
        expect(json[:errors]).to be_a Array
        expect(json[:errors].first).to have_key :message
        expect(json[:errors].first[:message]).to eq("Invalid attributes for User: Email has already been taken")
      end
    end

    describe "When params are missing" do
      it "does not create a user" do
        query2 =
          <<~GQL
            mutation {
              createUser(input: {params: { name: "Eli Fuchsman", email: ""}}){
                user {
                  id
                  name
                  email
                  apiKey
                }
              }
            }
          GQL

        result = LunchAndLearnGqlSchema.execute(query2).to_json
        json = JSON.parse(result, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :data
        expect(json[:data]).to be_a Hash
        expect(json[:data]).to have_key :createUser
        expect(json[:data][:createUser]).to be nil
        expect(json).to have_key :errors
        expect(json[:errors]).to be_a Array
        expect(json[:errors].first).to have_key :message
        expect(json[:errors].first[:message]).to eq("Invalid attributes for User: Email can't be blank")
      end
    end

    describe "when the user does not provide an input key in the query" do
      it "does returns errors", :vcr do
        query2 =
          <<~GQL
            mutation {
              createUser(params: { name: "Eli Fuchsman", email: "elif@mail.com"}){
                user {
                  id
                  name
                  email
                  apiKey
                }
              }
            }
          GQL

          result = LunchAndLearnGqlSchema.execute(query2).to_json
        json = JSON.parse(result, symbolize_names: true)

        expect(json).to have_key :errors
        expect(json[:errors]).to be_a Array
        expect(json[:errors].first).to have_key :message
        expect(json[:errors].first[:message]).to eq("Field 'createUser' is missing required arguments: input")
      end
    end
  end
end
