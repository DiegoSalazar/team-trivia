# frozen_string_literal: true

FactoryBot.define do
  factory :team_message do
    player
    team
    trivium_id {}
    body { Faker::Hacker.say_something_smart }

    factory :guess_message do
      guess
    end
  end
end
