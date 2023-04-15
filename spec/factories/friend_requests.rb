FactoryBot.define do
  factory :friend_request do
    status { "MyString" }
    friend_request_from { nil }
    friend_request_to { nil }
  end
end
