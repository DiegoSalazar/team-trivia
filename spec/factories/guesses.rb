FactoryBot.define do
  factory :guess do
    question_template
    value { "MyText" }
    cached_votes_up { 1 }
  end
end
