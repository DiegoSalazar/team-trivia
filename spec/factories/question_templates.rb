# frozen_string_literal: true

FactoryBot.define do
  factory :question_template do
    body { Faker::Hacker.say_something_smart.sub %r/\W$/, '?' }
    correct_answer { Faker::Hacker.phrases.sample }
  end
end
