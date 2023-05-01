class User < ApplicationRecord
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :group_permissions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_requests_from, class_name: 'FriendRequest', foreign_key: :friend_request_from_id, dependent: :destroy
  has_many :friend_requests_to, class_name: 'FriendRequest', foreign_key: :friend_request_to_id, dependent: :destroy
  has_and_belongs_to_many :groups, dependent: :destroy

end
