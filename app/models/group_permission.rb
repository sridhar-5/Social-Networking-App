class GroupPermission < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum role: [:member, :moderator, :admin]
end
