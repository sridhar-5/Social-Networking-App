class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  after_create :trigger_event
  def trigger_event(post_id)
    @create_friendship = Friendship.create!({"user" => User.find(user_id), "friend" => User.find(friend_id)})
  end

end
