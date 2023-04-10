FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    avatar { "MyString" }
    bio { "MyText" }
  end
end
