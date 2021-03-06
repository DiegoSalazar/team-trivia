# frozen_string_literal: true

FactoryBot.define do
  factory :team_message do
    player
    team
    trivium_id {}
    body { Faker::Hacker.say_something_smart }

    factory :guess_message do
      transient do
        question_template {}
      end

      after(:create) do |guess_message, evaluator|
        guess_message.guess = evaluator.guess || create(
          :guess,
          question_template: evaluator.question_template,
          player: evaluator.player,
          team: evaluator.team,
          trivium: evaluator.trivium
        )
      end
    end
  end
end
