FactoryBot.define do
  factory :trivium do
    title { 'MyText' }
    body { 'MyText' }
    game_starts_at { 3.hours.from_now }
    game_ends_at { game_starts_at + 15.minutes }

    transient do
      team_messages_count { 2 }
      guess_messages_count { 2 }
      question_count { 2 }
    end

    trait :far_future do
      game_starts_at { 3.months.from_now }
    end

    trait :expired do
      game_starts_at { 3.hours.ago }
    end

    after(:create) do |trivium, overrides|
      create_list :team_message, overrides.team_messages_count, trivium_id: trivium.id
      qts = create_list(:question_template, overrides.question_count).each do |question|
        create :trivium_question, trivium_id: trivium.id, question_template_id: question.id
      end
      create_list :guess_message, overrides.guess_messages_count, question_template: qts.first, trivium_id: trivium.id

      trivium.reload
    end
  end
end
