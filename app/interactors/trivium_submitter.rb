# frozen_string_literal: true

class TriviumSubmitter
  def self.ensure_submissions!(trivium)
    return if trivium.submissions.exists?

    new(trivium).create_submissions!
  end

  def initialize(trivium)
    @trivium = trivium
  end

  def create_submissions!
    guesses = @trivium.guesses.includes :team
    teams = guesses.map(&:team).uniq

    teams.each do |team|
      team.submissions.create! \
        correct_count: score_guesses(team),
        total: @trivium.questions.count,
        trivium: @trivium
    end
  end

  private

  def score_guesses(team)
    team.guesses.count do  |guess|
      guess.question.answers.any? { |answer| guess === answer }
    end
  end
end
