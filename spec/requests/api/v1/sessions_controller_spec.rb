require 'rails_helper'

describe "Sessions Controller" do
  it "User can login and recive their email and api key" do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")

    user_info = {
      email: "whatever@example.com",
      password: "password"
    }

    post "/api/v1/sessions", params: user_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

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

  it "Returns an error if email is incorrect" do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")

    user_info = {
      email: "whtever@example.com",
      password: "password"
    }

    post "/api/v1/sessions", params: user_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a(Hash)
    expect(result[:errors]).to eq("email or password is invalid")
  end

  it "Returns an error if passwords dont match" do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")
    user_info = {
      email: "whatever@example.com",
      password: "PassWord"
    }

    post "/api/v1/sessions", params: user_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a(Hash)
    expect(result[:errors]).to eq("email or password is invalid")
  end

  it "Returns an error if a field is missing" do
    User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")

    user_info = {
      email: "",
      password: "password"
    }

    post "/api/v1/sessions", params: user_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a(Hash)
    expect(result[:errors]).to eq("email or password is invalid")
  end

  it "Returns an error if user does not exist" do
    user_info = {
      email: "whatever@example.com",
      password: "password"
    }

    post "/api/v1/sessions", params: user_info.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a(Hash)
    expect(result[:errors]).to eq("email or password is invalid")
  end
end
