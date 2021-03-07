FactoryBot.define do
  factory :guess do
    value do
      %i[abbreviation adjective noun verb ingverb].map do |m|
        Faker::Hacker.send m
      end.sample
    end
    cached_votes_up { 1 }
    question_id {}

    trait :with_owners do
      player
      team
      trivium
    end
  end
end
