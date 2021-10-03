FactoryBot.define do
  factory :currency do
    title { Faker::Currency.unique.name }
    ticker { Faker::Currency.unique.code }

  end
end