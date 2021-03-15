# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    player
    body { Faker::Hacker.say_something_smart.sub %r/\W$/, '?' }

    trait :with_trivium do
      trivium
    end
  end
end
