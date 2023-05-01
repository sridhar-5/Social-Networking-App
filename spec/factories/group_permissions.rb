FactoryBot.define do
  factory :group_permission do
    user
    group
    role { GroupPermission.roles.keys.sample }
  end
end
