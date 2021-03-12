# frozen_string_literal: true

# Usage:
#   rake db:seed \
#     t=TEAM_COUNT
#     g=GUESS_COUNT
#     s=START_OFFSET_IN_MINS
#     e=END_OFFSET_IN_MINS

def create_realistic_trivium(questions, team_count, question_count, guess_count, starts_at, ends_at, i)
  puts "Creating Trivia #{i.succ}"
  trivium = FactoryBot.create :trivium, title: "Mixed Trivia #{i.succ}", body: 'A mysterious hint'

  print "Creating Questions and Answers"
  questions.each do |q|
    question = FactoryBot.create :question, body: q['body'], trivium: trivium
    FactoryBot.create(:answer, question: question, value: q['answer'])
    print ?.
  end

  print "\nCreating Teams" if team_count.positive?
  team_count.times do |i|
    FactoryBot.create :team, :with_players
    print ?.
  end

  Team.all.each_with_index do |team, t|
    print "\nGenerating data for Team #{t}"
    team.players.each_with_index do |player, p|
      print "\n  Creating data for Player #{p}"
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

    print "\nVoting on Guesses for Team #{t}"
    team.players.each do |player|
      next if rand > 0.3

      team.guesses.each do |guess|
        next if rand > 0.1

        guess.vote_by voter: player
        print ?.
      end
    end
    puts
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

  starts_at = 40.seconds.from_now
  starts_at = ENV['s'].to_i.seconds.from_now if ENV['s'].present?
  ends_at = starts_at + (ENV['e'] || 80).to_i.seconds
  trivia_count = (ENV['n'] || 1).to_i
  team_count = (ENV['t'] || 3).to_i
  guess_count = (ENV['g'] || 3).to_i
  question_count = (ENV['q'] || 20).to_i
  questions = JSON.parse File.read 'db/questions.json'
  questions = questions.take question_count

  print "\nCreating #{trivia_count} Trivia"

  trivia_count.times do |i|
    create_realistic_trivium \
      questions,
      team_count,
      question_count,
      guess_count,
      starts_at,
      ends_at,
      i
    print ?.
  end
  puts "\nDone."

rescue RuntimeError => e
  puts
  puts 'Seed aborted'
  raise e
end
