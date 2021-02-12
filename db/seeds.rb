# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  puts "Seeding the database!"
  player = Player.where(email: ENV['TEAM_TRIVIA_TEST_EM']).first

  if player.nil?
    player = Player.new
    player.email = ENV['TEAM_TRIVIA_TEST_EM']
    player.password = ENV['TEAM_TRIVIA_TEST_PW']
    player.save!
  end

  (ENV['n'] || 10).times do |i|
    starts_at = ((i + 1) * 10).minutes
    trivium = FactoryBot.create :trivium, {
      title: Faker::Marketing.buzzwords,
      body: Faker::Fantasy::Tolkien.poem,
      game_starts_at: starts_at.from_now,
      game_ends_at: (starts_at + 15.minutes).from_now,
      question_count: 10
    }
    trivium.question_templates.each do |question|
      question.update! body: Faker::Fantasy::Tolkien.poem
    end
  end
end
