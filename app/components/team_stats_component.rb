# frozen_string_literal: true

class TeamStatsComponent < ViewComponent::Base
  def initialize(team)
    super
    @team = team
  end

  def games
    @team.submissions.count
  end

  def points
    @team.guesses.includes(question: :answers).sum(&:points)
  end

  def guesses
    @team.guesses.count
  end

  def votes
    @team.players.sum { |p| p.votes.count }
  end
end
