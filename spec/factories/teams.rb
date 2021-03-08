# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Superhero.name.pluralize }

    trait :with_players do
      transient do
        player_count { 5 }
      end

      after :create do |team, evaluator|
        players = create_list :player, evaluator.player_count

        players.each do |player|
          create :join, player: player, team: team
        end
      end
    end
  end
end
