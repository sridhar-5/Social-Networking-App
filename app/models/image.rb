class Image < ApplicationRecord
  belongs_to :post

  validates :url , presence: true
end
