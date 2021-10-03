FactoryBot.define do
  factory :account do
    amount { 50 }
    user { FactoryBot.create(:user) }
    currency { FactoryBot.create(:currency) }

  end
end