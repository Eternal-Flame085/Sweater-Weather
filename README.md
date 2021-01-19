
# Sweater Weather
## Table of Contents
- [Description](#description)
- [Learning Goals](#learning-goals)
- [Setup](#setup)
- [Endpoints](#endpoints)
  - [Retrieve weather for a city](#retrieve weather)
  - [Background Image for the City](#background)
  - [User Registration](#user registration)
  - [Login](#login)
  - [Road Trip](#road trip)

<!-- DESCRIPTION -->
## Description
This app will allow users to see the current weather as well as the forecasted weather at the destination.

<!-- LEARNING GOALS -->
## Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Research, select, and consume an API based on your needs as a developer

<!-- SETUP -->
## Setup
This project requires the use of Ruby ```2.5.3``` and Rails ```5.2.4.3```

1. Clone this repo `https://github.com/Eternal-Flame085/Sweater-Weather`

2. Enter the directory it was cloned into `cd Sweater-Weather`

3. Run `bundle install` to install gems and dependencies

4. Run `bundle exec rails db:{create,migrate}` to set up the database and to run the migrations
5. Get Api keys for 
7. Run `Figaro install` to make the application.yml file

<!-- ENDPOINTS -->
## Endpoints

<!-- RETRIEVE WEATHER -->
### Retrieve weather for a city
This endpoint allows you to get the weather information for the destination.<br><br>
Example request: ```GET /api/v1/forecast?location=denver,co```<br>
Query parameters:
- Location (required)
- units (optional)

<!-- BACKGROUND -->
### Background Image for the City
This endpoint allows you to get a background image for the destination.<br><br>
Example request: ```GET /api/v1/backgrounds?location=denver,co```<br>
Query parameters:
- Location (required)

<!-- USER REGRISTRATION -->
### User Registration
This endpoint allows for user registration.<br><br>
Example request: ``` POST /api/v1/users```
This Endpoint requires a json payload to be sent in the body:
```
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

<!-- LOGIN -->
### Login
This endpoint allows a user to login and returns their apikey as a response.<br><br>
Example request: ``` POST /api/v1/sessions ```
This Endpoint requires a json payload to be sent in the body:
```
{
  "email": "whatever@example.com",
  "password": "password"
}
```

<!-- ROADTRIP -->
### Road Trip
This endpoint returns information required for a roadtrip.<br><br>
Example request: ```POST /api/v1/road_trip ```
This Endpoint requires a json payload to be sent in the body with the following required parameters:
```
{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```
