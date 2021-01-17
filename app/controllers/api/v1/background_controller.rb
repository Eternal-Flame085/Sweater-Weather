class Api::V1::BackgroundController < ApplicationController
  def index
    render json: ImageSerializer.new(BackgroundFacade.find_image(params[:location]))
  end
end
