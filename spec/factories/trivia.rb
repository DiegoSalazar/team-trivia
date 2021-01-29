FactoryBot.define do
  factory :trivium do
    title { 'MyText' }
    body { 'MyText' }
    game_starts_at { 3.hours.from_now }
    game_ends_at { game_starts_at + 15.minutes }
  end
end
