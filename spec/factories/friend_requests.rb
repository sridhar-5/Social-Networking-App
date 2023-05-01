FactoryBot.define do
  factory :friend_request do
    status { FriendRequest.status.keys.sample }
    association :friend_request_from, factory: :user
    association :friend_request_to, factory: :user
  end
end
