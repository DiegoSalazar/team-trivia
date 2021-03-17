FactoryBot.define do
  factory :trivium do
    player
    title { Faker::Hacker.phrases.sample }
    body { Faker::Hacker.say_something_smart }
    game_starts_at { 3.hours.from_now }
    game_ends_at { game_starts_at + 15.minutes }

    trait :far_future do
      game_starts_at { 3.months.from_now }
    end

    trait :expired do
      game_starts_at { 3.hours.ago }
    end

    trait :active do
      game_starts_at { 1.second.ago }
    end

    trait :populated do
      transient do
        team_messages_count { 2 }
        guess_messages_count { 2 }
        question_count { 2 }
      end

      after(:create) do |trivium, overrides|
        create_list :team_message, overrides.team_messages_count, trivium_id: trivium.id
        questions = create_list :question, overrides.question_count, trivium: trivium
        create_list :guess_message, overrides.guess_messages_count, question: questions.first, trivium_id: trivium.id
        trivium.reload
      end
    end
  end
end
