FactoryBot.define do
  factory :guess do
    question_template
    value do
      %i[abbreviation adjective noun verb ingverb].map do |m|
        Faker::Hacker.send m
      end.sample
    end
    cached_votes_up { 1 }
  end
end
