class Api::V1::UserController < ApplicationController
  def create
    user = User.create!(user_params)

    # login user right away
    if user
      session[:user_id] = user.id
      render json: {
        status: :created,
        logged_in: true,
        user: user.slice(:name, :username, :email, :avatar, :bio)
      }
    else
      render json: {status: :unprocessable_entity}
    end
  end


  private
  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
  end
end
