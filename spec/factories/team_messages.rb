# frozen_string_literal: true

FactoryBot.define do
  factory :team_message do
    player
    team
    body { Faker::Hacker.say_something_smart }

    trait :with_trivium do
      trivium
    end

    factory :guess_message do
      transient do
        question {}
        cached_votes_up {}
      end

      after(:create) do |guess_message, evaluator|
        guess = evaluator.guess || create(
          :guess,
          question: evaluator.question,
          player: evaluator.player,
          team: evaluator.team,
          trivium: evaluator.trivium,
          cached_votes_up: evaluator.cached_votes_up
        )
        guess_message.guess = guess
        guess_message.save!
      end
    end
  end
end
