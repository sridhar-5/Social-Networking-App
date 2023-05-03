FactoryBot.define do
  factory :group_permission do
    user { User.all.sample }
    group { Group.all.sample }
    role { GroupPermission.roles.keys.sample }
  end
end
