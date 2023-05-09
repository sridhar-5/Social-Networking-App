FactoryBot.define do
  factory :reaction do
    reaction_type { Reaction.reaction_types.keys.sample }
    user
    post
  end
end
