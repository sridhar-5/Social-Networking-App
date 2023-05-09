class Reaction < ApplicationRecord
  enum reaction_type: {like: 8, funny: 9, congratulate: 10, support: 11, informative: 12}
  validates :reaction_type, presence: true
  belongs_to :user
  belongs_to :post

  #TODO: FEATURE SCOPE: Like can exist not only for posts, but also for comments look into this too
end
