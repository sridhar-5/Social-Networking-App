FactoryBot.define do
  factory :group do
    name { Faker::Team.name  }
    description { Faker::Lorem.paragraph }
    image_url { Faker::Internet.url }
    user
  end
end
