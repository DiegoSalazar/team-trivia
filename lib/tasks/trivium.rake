# frozen_string_literal: true

namespace :trivium do
  desc 'Delete and everything and re-seed'
  task reseed: :delete_all do
    puts nil, 'Seeding...'
    Rake::Task['db:seed'].invoke
  end

  desc 'delete everything and start with Player and Team 0'
  task fresh_start: %i[delete_all create_first_team]

  desc 'Call delete_all and every model class'
  task delete_all: :environment do
    # Force models to load
    Dir[Rails.root.join('app/models/**/*.rb')].map { |f| require f }

    ActiveRecord::Base.transaction do
      ActiveRecord::Base.descendants.each do |model_class|
        next if [ApplicationRecord, Player].include? model_class

        model_class.delete_all
        puts "Deleted #{model_class.name}"
      rescue ActiveRecord::StatementInvalid => e
        $stderr.warn e.class, e.message
      end
    end
  end

  desc 'Create Player 0, 1, and the first Team'
  task create_first_team: :environment do
    raise KeyError, 'missing env var TEAM_TRIVIA_TEST_EM' if ENV['TEAM_TRIVIA_TEST_EM'].blank?

    puts 'Creating Player 0'
    player = FactoryBot.create :player, email: ENV['TEAM_TRIVIA_TEST_EM']
    player.password = ENV['TEAM_TRIVIA_TEST_PW']
    player.save!
    puts 'Creating Team 0'
    team = FactoryBot.create :team, :with_players
    player.team = team

    puts 'Creating Player 1'
    player2 = FactoryBot.create :player, email: ENV['TEAM_TRIVIA_TEST_EM2']
    player2.password = ENV['TEAM_TRIVIA_TEST_PW2']
    player2.save!
    player2.team = team
  end

  desc 'reset game start time of first trivium'
  task reset: :environment do
    Trivium.transaction do
      Trivium.find_each.with_index do |trivium, i|
        next if i < 2 # leave some in the past

        reset_trivium trivium, i - 2
      end
    end
  end

  desc 'reset with random number and set of questions'
  task reset_with_rand_questions: :environment do
    Trivium.transaction do
      Trivium.find_each.with_index do |trivium, i|
        next if i < 2 # leave some in the past

        reset_trivium trivium, i - 2
        drop_questions = trivium.questions.sample rand(trivium.questions.count)
        drop_questions.map(&:destroy!)
      end
    end
  end

  def reset_trivium(trivium, i)
    starts_at = 40.seconds.from_now
    starts_at = ENV['s'].to_i.seconds.from_now if ENV['s'].present?
    starts_at += i.minutes
    ends_at = starts_at + (ENV['e'] || 80).to_i.seconds

    puts "#{i} Resetting Trivium #{trivium.id} to start at #{starts_at}"

    trivium.game_starts_at = starts_at
    trivium.game_ends_at = ends_at
    trivium.save!
    trivium.questions.each { |q| q.update! revealed: 0, active: false }
  end
end
