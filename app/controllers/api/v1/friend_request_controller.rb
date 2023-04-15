class Api::V1::FriendRequestController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get all the pending friend requests the current user has and order them with date time of creation
    if current_user
      @friend_requests = FriendRequest.where(friend_request_to: current_user).where(status: :pending).order(created_at: :desc)
      render json: {
        friend_requests: @friend_requests
      }
    else
      head(:unauthorized)
    end
  end

  def create
    if current_user
      data = friend_request_params
      @friend_request = FriendRequest.create!({friend_request_from: current_user, friend_request_to: User.find(data["friend_id"]), status: :pending })
      render json: {
        message: "Friend request sent"
      }
    else
      head(:unauthorized)
    end
  end

  def accept_request
    if current_user
      data = accept_request_params
      @accept_friend_request = FriendRequest.find_by(friend_request_from_id: data["friend_id"], friend_request_to_id: current_user.id)
      @accept_friend_request.update!(status: :accepted)
      if @accept_friend_request.saved_change_to_status?
        @accept_friend_request.trigger_event(current_user.id, data["friend_id"])
      end
      render json: {
        message: "friend request from #{data["friend_id"]} accepted"
      }
    end
  end

  def reject_request
    if current_user
      data = reject_request_params
      @reject_friend_request = FriendRequest.find_by(friend_request_from_id: data["friend_id"], friend_request_to_id: current_user.id)
      @reject_friend_request.update!(status: :rejected)

      render json: {
        message: "friend request from #{data["friend_id"]} rejected"
      }
    end
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:friend_id)
  end

  def accept_request_params
    params.require(:accept_request).permit(:friend_id)
  end

  def reject_request_params
    params.require(:reject_request).permit(:friend_id)
  end
end
