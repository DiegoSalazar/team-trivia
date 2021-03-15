# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Superhero.name.pluralize }

    trait :with_players do
      transient do
        player_count { 5 }
      end

      after :create do |team, evaluator|
        team.players = create_list :player, evaluator.player_count
      end
    end
  end
end
