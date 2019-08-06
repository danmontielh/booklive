FactoryBot.define do
  factory :comment do
    association :post, factory: :post
    association :user, factory: :user
    body { Faker::Lorem.paragraph(2) }
  end
end
