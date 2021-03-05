# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_trivia(i, team, offset = ENV['offset'])
  offset = (offset || 20).to_i
  starts_at = (i.succ * offset).seconds
  trivium = FactoryBot.create \
    :trivium,
    title: Faker::Marketing.buzzwords.capitalize,
    body: Faker::Fantasy::Tolkien.poem,
    game_starts_at: starts_at.from_now,
    game_ends_at: (starts_at + 15.minutes).from_now,
    question_count: 10

  trivium.question_templates.each do |question|
    question.update! body: Faker::Fantasy::Tolkien.poem

    FactoryBot.create \
      :guess,
      question_template: question,
      cached_votes_up: [0, 1].sample
  end

  team.players.each do |p|
    FactoryBot.create :team_message, trivium: trivium, player: p, team: team
  end
end

ActiveRecord::Base.transaction do
  puts 'Seeding the database!'

  player = FactoryBot.create :player, email: ENV['TEAM_TRIVIA_TEST_EM']
  player.password = ENV['TEAM_TRIVIA_TEST_PW']
  player.save!
  team = FactoryBot.create :team_with_players
  player.teams << team

  num = (ENV['n'] || 20).to_i
  num.times { |i| create_trivia i, team }

rescue RuntimeError => e
  $stderr.warn 'Seed aborted'
  raise e
end
