class Api::V1::UserController < ApplicationController

  before_action :authenticate_user!, only: [:index, :destroy]
  def create
    user = User.create!(user_params)

    # login user right away
    if user
      headers['X-User-Token'] = user.authentication_token
      render json: {
        status: :created,
        user: user.slice(:name, :username, :email, :avatar, :bio)
      }
    else
      render json: {status: :unprocessable_entity}
    end
  end

  def destroy
    if current_user
      User.destroy!(current_user)
    end
  end

  def index
    # Get the Profile information includes: [No.of.friends, No of Posts]
    if current_user
      count_friends = Friendship.where(user: current_user).count
      count_posts = Post.where(user: current_user).count

      render json: {
        status: :ok,
        "posts_count": count_posts,
        "friend_count": count_friends
      }
    else
      head(:unauthorized)
    end
  end

  # TODO: Think about how to implement the patch route for user profile.

  private
  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
  end
end
