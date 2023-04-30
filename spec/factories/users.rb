FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    email { Faker::Internet.email(name: name) }
    username {Faker::Internet.username }
    password {Faker::Internet.password }
  end
end

