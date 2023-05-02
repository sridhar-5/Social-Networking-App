FactoryBot.define do
  factory :comment do
    user { User.all.sample }
    post { Post.all.sample }
    content { Faker::Lorem.sentence }
  end
end
