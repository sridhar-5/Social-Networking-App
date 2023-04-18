FactoryBot.define do
  factory :group_permission do
    user { nil }
    group { nil }
    role { "MyString" }
  end
end
