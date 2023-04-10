class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :different_users
  # ensures that there are no duplicate entries in friends table where friend_id and user_id are repeated
  validates :user_id, uniqueness: { scope: :friend_id }
  validates :friend_id, uniqueness: { scope: :user_id }


  private

  def different_users
    errors.add(:friend_id, 'cannot be the same as user_id') if user_id == friend_id
  end
end