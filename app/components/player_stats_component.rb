# frozen_string_literal: true

class PlayerStatsComponent < ViewComponent::Base
  def initialize(player)
    super
    @player = player
  end

  def games
    @player.team.submissions.count
  end

  def points
    @player.guesses.sum(&:points)
  end

  def guesses
    @player.guesses.count
  end

  def votes
    @player.votes.count
  end
end
