# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_random_trivia(i, team, offset = ENV['offset'])
  offset = (offset || 20).to_i
  starts_at = (i.succ * offset).seconds
  trivium = FactoryBot.create \
    :trivium,
    title: Faker::Marketing.buzzwords.capitalize,
    body: Faker::Fantasy::Tolkien.poem,
    game_starts_at: starts_at.from_now,
    game_ends_at: (starts_at + 15.minutes).from_now,
    question_count: 10

  trivium.questions.each do |question|
    question.update! body: Faker::Fantasy::Tolkien.poem
  end

  team.players.each do |player|
    FactoryBot.create \
      :guess_message,
      question: trivium.questions.sample,
      player: player,
      team: team,
      trivium: trivium,
      cached_votes_up: [0, 1].sample

    next if [true, false].sample

    FactoryBot.create \
      :team_message,
      trivium: trivium,
      player: player,
      team: team
  end
end

ActiveRecord::Base.transaction do
  puts 'Creating randomized Trivia...'

  player = FactoryBot.create :player, email: ENV['TEAM_TRIVIA_TEST_EM']
  player.password = ENV['TEAM_TRIVIA_TEST_PW']
  player.save!
  team = FactoryBot.create :team_with_players
  player.teams << team

  player2 = FactoryBot.create :player, email: ENV['TEAM_TRIVIA_TEST_EM2']
  player2.password = ENV['TEAM_TRIVIA_TEST_PW2']
  player2.save!
  player2.teams << team

  num = (ENV['n'] || 20).to_i
  num.times do |i|
    print ?.
    create_random_trivia i, team
  end
  puts

rescue RuntimeError => e
  puts
  $stderr.warn 'Seed aborted'
  raise e
end
