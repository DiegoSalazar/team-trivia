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

    after(:create) do |trivium, overrides|
      create_list :team_message, overrides.team_messages_count, trivium_id: trivium.id
      create_list :guess_message, overrides.guess_messages_count, trivium_id: trivium.id

      create_list(:question_template, overrides.question_count).each do |question|
        create :trivium_question, trivium_id: trivium.id, question_template_id: question.id
      end

      trivium.reload
    end
  end
end
