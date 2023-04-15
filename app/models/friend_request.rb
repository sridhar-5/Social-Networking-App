class FriendRequest < ApplicationRecord
  belongs_to :friend_request_from, class_name: 'User'
  belongs_to :friend_request_to, class_name: 'User'
  after_update :trigger_event, if: :status_changed?

  enum status: { pending: 0, accepted: 1, rejected: 2 }


  validates :friend_request_to_id, uniqueness: { scope: :friend_request_from_id }
  validates :friend_request_from_id, uniqueness: { scope: :friend_request_to_id }


  def trigger_event(user_id, friend_id)
    @create_friendship = Friendship.create!({"user" => User.find(user_id), "friend" => User.find(friend_id)})
  end

  private

  def different_users
    errors.add(:friend_request_to_id, 'cannot send friend request to yourself') if friend_request_to_id == friend_request_from_id
  end
end
