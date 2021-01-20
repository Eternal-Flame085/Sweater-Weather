class Api::V1::TripsController < ApplicationController
  def create
    units = 'imperial'
    units = params[:units] if !params[:units].nil?
    if params[:api_key].nil? || User.find_by(api_key: params[:api_key]).nil?
      render status: 401, json: { errors: "Unauthorized"}
    else
      road_trip = RoadTripFacade.fetch_road_trip_info(route_params, units)
      render status: 201, json: RoadtripSerializer.new(road_trip)
    end
  end

  private

  def route_params
    params.permit(:origin, :destination)
  end
end
