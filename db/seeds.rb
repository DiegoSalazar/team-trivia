# frozen_string_literal: true

def create_realistic_trivium(questions, team_count, starts_at, ends_at)
  puts 'Creating Trivia'
  trivium = FactoryBot.create :trivium, title: 'Mixed Trivia', body: 'A mysterious hint'

  puts 'Creating Questions and Answers'
  questions.each do |q|
    question = FactoryBot.create :question, body: q['body'], trivium: trivium
    FactoryBot.create(:answer, question: question, value: q['answer'])
    print ?.
  end

  puts nil, 'Creating Teams' if team_count.positive?
  teams = team_count.times.map do |i|
    FactoryBot.create :team, :with_players
    print ?.
  end

  Team.all.each_with_index do |team, t|
    puts "\nPopulating data for Team #{t}"
    team.players.each_with_index do |player, p|
      puts "Creating data for Team #{t}, Player #{p}"
      if rand > 0.5
        FactoryBot.create :team_message, player: player, team: team, trivium: trivium
        print ?.
      end

      trivium.questions.each do |question|
        next if rand > 0.7

        guess = create_guess_for player, question, team, trivium
        FactoryBot.create :guess_message, player: player, team: team, trivium: trivium, question: question, guess: guess
        print ?.
      end
    end

    puts "\nVoting on Guesses for Team #{t}"
    team.players.each do |player|
      team.guesses.each do |guess|
        next if rand > 0.7

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
  attributes = { player: player, question: question, team: team, trivium: trivium }
  attributes[:value] = question.answers.first.value if rand > 0.3
  FactoryBot.create :guess, attributes
end

ActiveRecord::Base.transaction do
  puts 'Creating Player 1'
  player = FactoryBot.create :player, email: ENV['TEAM_TRIVIA_TEST_EM']
  player.password = ENV['TEAM_TRIVIA_TEST_PW']
  player.save!
  puts 'Creating Team 1'
  team = FactoryBot.create :team, :with_players
  player.teams << team

  puts 'Creating Player 2'
  player2 = FactoryBot.create :player, email: ENV['TEAM_TRIVIA_TEST_EM2']
  player2.password = ENV['TEAM_TRIVIA_TEST_PW2']
  player2.save!
  player2.teams << team

  starts_at = 20.seconds.from_now
  ends_at = starts_at + (ENV['e'] || 1.1).minutes
  starts_at = ENV['s'].to_i.minutes.from_now if ENV['mins'].present?
  questions = JSON.parse File.read 'db/questions.json'
  team_count = (ENV['teams'] || 5).to_i

  create_realistic_trivium questions, team_count, starts_at, ends_at
  puts 'Done'

rescue RuntimeError => e
  puts
  puts 'Seed aborted'
  raise e
end
