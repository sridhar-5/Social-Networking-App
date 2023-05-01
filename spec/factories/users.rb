FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    email { Faker::Internet.email(name: name) }
    username {Faker::Internet.username }
    password {Faker::Internet.password }
    isAdmin { false }


    # if the user is admin just role changes so
    trait :admin do
      isAdmin {true}
    end

  end
end

