class Api::V1::SessionController < ApplicationController

  def create
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      # head(:created)
      render json: user.as_json(only: [:email, :authentication_token])
    else
      head(:unauthorized)
    end

  end

  def destroy

  end
end