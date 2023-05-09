class Post < ApplicationRecord
  belongs_to :user
  has_many :reactions, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
end
