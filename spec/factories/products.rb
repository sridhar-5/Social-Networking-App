FactoryBot.define do
  factory :product do
    name { "MyString" }
    price { 1.5 }
    location { "MyString" }
    description { "MyString" }
    user { nil }
  end
end
