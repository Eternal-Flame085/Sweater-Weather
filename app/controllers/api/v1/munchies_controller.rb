class Api::V1::MunchiesController < ApplicationController
  def index
    render json: MunchieSerializer.new(MunchiesFacade.find_food_for_destination(munchies_params))
  end

  private

  def munchies_params
    params.permit(:start, :end, :food)
  end
end
