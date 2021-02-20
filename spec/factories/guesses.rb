FactoryBot.define do
  factory :guess do
    question_template
    value { Faker::Hacker.say_something_smart }
    cached_votes_up { 1 }
  end
end
