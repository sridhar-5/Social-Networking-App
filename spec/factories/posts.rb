FactoryBot.define do
  factory :post do
    content { Faker::Lorem.paragraph }
    user { User.all.sample }
  end
end
