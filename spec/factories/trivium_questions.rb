FactoryBot.define do
  factory :trivium_question do
    sequence(:trivium_id) { |n| n }
    sequence(:question_template_id) { |n| n }
  end
end
