FactoryBot.define do
  factory :answer do
    value { Faker::Marketing.buzzwords }
  end
end
