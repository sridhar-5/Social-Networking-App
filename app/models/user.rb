class User < ApplicationRecord
  acts_as_token_authenticatable

  #@TODO DIG DEEPER INTO WHAT THESE METHODS ARE DOING
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :group_permissions
  has_many :posts, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_requests, dependent: :destroy
  has_and_belongs_to_many :groups
end
