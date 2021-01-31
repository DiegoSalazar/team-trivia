# frozen_string_literal: true

FactoryBot.define do
  factory :team_message do
    player
    team
    trivium_id {}
    body { 'MyText' }

    factory :guess_message do
      guess
    end
  end
end
