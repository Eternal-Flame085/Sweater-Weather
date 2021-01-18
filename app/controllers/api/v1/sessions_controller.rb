class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if !user.nil? && user.authenticate(params[:password])
      render status: 201, json: UserSerializer.new(user)
    else
      render status: 400, json: { errors: "email or password is invalid"}
    end
  end
end
