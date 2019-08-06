FactoryBot.define do
  factory :friendship do
    association :friend_invite, factory: :user
    association :invited_friend, factory: :user
  end
end
