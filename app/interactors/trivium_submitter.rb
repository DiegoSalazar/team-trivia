# frozen_string_literal: true

class TriviumSubmitter
  def self.ensure_submissions!(trivium)
    # binding.pry # debug
    # return unless trivium.ended?
    return if trivium.submissions.exists?

    new(trivium).create_submissions!
  end

  def initialize(trivium)
    @trivium = trivium
  end

  def create_submissions!
    guesses = @trivium.guesses.includes :team, question: :answers
    teams = guesses.map(&:team).uniq

    Team.transaction do
      teams.each do |team|
        team.submissions.create! score: score(team), trivium: @trivium
      end
    end
  end

  private

  def score(team)
    team.top_guesses_for_all(@trivium.questions).count(&:correct?)
  end
end
