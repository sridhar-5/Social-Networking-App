class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true, length: { maximum: 1000, minimum: 1 }
end
