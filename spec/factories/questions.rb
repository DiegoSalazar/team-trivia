# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    player
    body { Faker::Hacker.say_something_smart.sub(/\W$/, '?') }

    trait :with_trivium do
      trivium
    end

    trait :free_text # default

    trait :multiple_choice do
      question_type { 'multiple_choice' }

      transient do
        answer_count { 3 }
      end

      after(:create) do |question, evaluator|
        create_list :answer, evaluator.answer_count, question: question
      end
    end
  end
end
