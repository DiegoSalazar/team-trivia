# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    body { Faker::Hacker.say_something_smart.sub %r/\W$/, '?' }
    correct_answer { Faker::Hacker.phrases.sample }

    trait :with_trivium do
      trivium
    end
  end
end
