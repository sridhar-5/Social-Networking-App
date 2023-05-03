FactoryBot.define do
  factory :image do
    url { Faker::Internet.url }
    post { Post.all.sample }
  end
end
