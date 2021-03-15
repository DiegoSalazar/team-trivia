# frozen_string_literal: true

# Usage:
#   rake db:seed \
#     t=TEAM_COUNT
#     g=GUESS_COUNT
#     s=START_OFFSET_IN_MINS
#     e=END_OFFSET_IN_MINS

def create_realistic_trivium(player, questions, team_count, guess_count, i)
  puts "\nCreating Trivia #{i.succ}"
  trivium = FactoryBot.create \
    :trivium,
    title: "Mixed Trivia #{i.succ}",
    body: 'A mysterious hint'

  if i.zero? # only create teams once
    print "\nCreating #{team_count} Teams" if team_count.positive?
    FactoryBot.create_list :team, team_count, :with_players
  end

  print "\n#{i.succ}: Creating Questions and Answers"
  questions.each do |q|
    question = FactoryBot.create \
      :question,
      body: q['body'],
      trivium: trivium,
      player: player
    FactoryBot.create \
      :answer,
      question: question,
      value: q['answer'],
      points: 1
    print ?.
  end

  Team.all.each_with_index do |team, t|
    print "\n#{i.succ}: Team #{t} -> "

    team.players.each_with_index do |plyr, p|
      if rand > 0.5
        print "Player #{p}"
        FactoryBot.create \
          :team_message,
          player: plyr,
          team: team,
          trivium: trivium
        print ?.
      end
      print ' '

      guess_count.times do
        trivium.questions.each_with_index do |question, q|
          next if rand > 0.1
          print "Q#{q}"

          FactoryBot.create \
            :guess_message,
            player: player,
            team: team,
            trivium: trivium,
            question: question,
            guess: create_guess_for(player, question.reload, team, trivium)
          print ?.
        end
        print ' '
      end
    end

    print "\n#{i.succ}: Voting Team #{t}"
    team.players.each do |p|
      next if rand > 0.3

      team.guesses_for(trivium).each do |guess|
        next if rand > 0.1

        guess.vote_by voter: p
        print ?.
      end
    end
    puts
  end

  trivium
end

def create_guess_for(player, question, team, trivium)
  attributes = { player: player, question: question, team: team, trivium: trivium, cached_votes_up: 0 }
  attributes[:value] = question.answers.first.value if rand > 0.3
  attributes[:value] = question.guesses.sample&.value if rand > 0.3
  attributes.delete :value if attributes[:value].nil?
  FactoryBot.create :guess, attributes
end

ActiveRecord::Base.transaction do
  Rake::Task['trivium:create_first_team'].invoke if Player.count.zero?

  player = Player.first
  trivia_count = (ENV['n'] || 1).to_i
  team_count = (ENV['t'] || 3).to_i
  guess_count = (ENV['g'] || 3).to_i
  question_count = (ENV['q'] || 20).to_i
  questions = JSON.parse File.read 'db/questions.json'
  questions = questions.take question_count

  print "\nCreating #{trivia_count} Trivia"

  trivia = trivia_count.times.map do |i|
    t = create_realistic_trivium \
      player,
      questions,
      team_count,
      guess_count,
      i
    print ?.
    t
  end

  trivia.each_with_index do |trivium, i|
    starts_at = Time.now + i * 60
    starts_at += 20.seconds if i > 0
    starts_at = (ENV['s'].to_i + i * 60).seconds.from_now if ENV['s'].present?
    ends_at = starts_at + (ENV['e'] || 80).to_i.seconds

    trivium.game_starts_at = starts_at
    trivium.game_ends_at = ends_at
  end

  trivia.each &:save!
  puts "\nDone."

rescue RuntimeError => e
  puts
  puts 'Seed aborted'
  raise e
end
