class Group < ApplicationRecord
  belongs_to :user
  has_many :group_permissions
  has_and_belongs_to_many :users  # the reason behind using the has_and_belong_to_many instead of has_many through here is because i don't think there is a need to create a new model for the join table for this case.

  validates :name, presence: true, length: { minimum: 1, maximum: 150 }
end
