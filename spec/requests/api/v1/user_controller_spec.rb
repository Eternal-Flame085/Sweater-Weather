require 'rails_helper'

describe "Creating user" do
  it "Can create a user" do
    user_info = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }

    post "/api/v1/users", params: user_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to be_successful
    expect(response.status).to eq(201)
    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to be_a(Hash)
    expect(user[:data]).to be_a(Hash)
    expect(user[:data].keys).to eq([:id, :type, :attributes])
    expect(user[:data][:id]).to be_a(String)
    expect(user[:data][:type]).to be_a(String)
    expect(user[:data][:attributes]).to be_a(Hash)

    expect(user[:data][:attributes].keys).to eq([:email, :api_key])
    expect(user[:data][:attributes][:email]).to be_a(String)
    expect(user[:data][:attributes][:email]).to eq("whatever@example.com")
    expect(user[:data][:attributes][:api_key]).to be_a(String)
  end

  it "Returns an error if email has been taken" do
    User.create(email: "WHATEVER@example.com", password: "password", password_confirmation: "password")

    user_info = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }

    post "/api/v1/users", params: user_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a(Hash)
    expect(result[:errors]).to eq("Email has already been taken")
  end

  it "Returns an error if passwords dont match" do
    user_info = {
      email: "whatever@example.com",
      password: "PassWord",
      password_confirmation: "password"
    }

    post "/api/v1/users", params: user_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a(Hash)
    expect(result[:errors]).to eq("Password confirmation doesn't match Password and Password confirmation doesn't match Password")
  end

  it "Returns an error if a field is missing" do
    user_info = {
      email: "",
      password: "password",
      password_confirmation: "password"
    }

    post "/api/v1/users", params: user_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a(Hash)
    expect(result[:errors]).to eq("Email can't be blank")
  end
end
