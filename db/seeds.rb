# frozen_string_literal: true

# Usage:
#   rake db:seed \
#     t=TEAM_COUNT
#     g=GUESS_COUNT
#     s=START_OFFSET_IN_MINS
#     e=END_OFFSET_IN_MINS

def create_realistic_trivium(questions, team_count, guess_count, starts_at, ends_at)
  puts 'Creating Trivia'
  trivium = FactoryBot.create :trivium, title: 'Mixed Trivia', body: 'A mysterious hint'

  puts 'Creating Questions and Answers'
  questions.each do |q|
    question = FactoryBot.create :question, body: q['body'], trivium: trivium
    FactoryBot.create(:answer, question: question, value: q['answer'])
    print ?.
  end

  puts nil, 'Creating Teams' if team_count.positive?
  team_count.times do |i|
    FactoryBot.create :team, :with_players
    print ?.
  end

  Team.all.each_with_index do |team, t|
    puts "\nGenerating data for Team #{t}"
    team.players.each_with_index do |player, p|
      puts "\nCreating data for Team #{t}, Player #{p}"
      if rand > 0.5
        FactoryBot.create :team_message, player: player, team: team, trivium: trivium
        print ?.
      end

      guess_count.times do
        trivium.questions.each do |question|
          next if rand > 0.1

          guess = create_guess_for player, question.reload, team, trivium
          FactoryBot.create :guess_message, player: player, team: team, trivium: trivium, question: question, guess: guess
          print ?.
        end
      end
    end

    puts "\nVoting on Guesses for Team #{t}"
    team.players.each do |player|
      next if rand > 0.3

      team.guesses.each do |guess|
        next if rand > 0.1

        player.vote_up_for guess
        print ?.
      end
    end
  end

  trivium.game_starts_at = starts_at
  trivium.game_ends_at = ends_at
  trivium.save!
end

def create_guess_for(player, question, team, trivium)
  attributes = { player: player, question: question, team: team, trivium: trivium, cached_votes_up: 0 }
  attributes[:value] = question.answers.first.value if rand > 0.3
  attributes[:value] = question.guesses.sample&.value if rand > 0.4
  attributes.delete :value if attributes[:value].nil?
  FactoryBot.create :guess, attributes
end

ActiveRecord::Base.transaction do
  if Player.count.zero?
    puts 'Creating Player 0'
    player = FactoryBot.create :player, email: ENV['TEAM_TRIVIA_TEST_EM']
    player.password = ENV['TEAM_TRIVIA_TEST_PW']
    player.save!
    puts 'Creating Team 0'
    team = FactoryBot.create :team, :with_players
    player.teams << team

    puts 'Creating Player 1'
    player2 = FactoryBot.create :player, email: ENV['TEAM_TRIVIA_TEST_EM2']
    player2.password = ENV['TEAM_TRIVIA_TEST_PW2']
    player2.save!
    player2.teams << team
  end

  questions = JSON.parse File.read 'db/questions.json'
  starts_at = 1.minute.from_now
  starts_at = ENV['s'].to_i.minutes.from_now if ENV['mins'].present?
  ends_at = starts_at + (ENV['e'] || 1.2).minutes
  team_count = (ENV['t'] || 3).to_i
  guess_count = (ENV['g'] || 3).to_i

  create_realistic_trivium questions, team_count, guess_count, starts_at, ends_at
  puts "\nDone."

rescue RuntimeError => e
  puts
  puts 'Seed aborted'
  raise e
end
