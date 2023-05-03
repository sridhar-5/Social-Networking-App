class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  #TODO: FEATURE SCOPE: Like can exist not only for posts, but also for comments look into this too
end
