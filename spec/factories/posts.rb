FactoryBot.define do
  factory :post do
    association :user, factory: :user
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph(2) }
  end
end
