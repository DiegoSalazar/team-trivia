# frozen_string_literal: true

FactoryBot.define do
  factory :question_template do
    body { Faker::Hacker.say_something_smart.sub %r/\W$/, '?' }
  end
end
