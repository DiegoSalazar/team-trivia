# frozen_string_literal: true

class TriviumWinnersComponent < ViewComponent::Base
  def initialize(trivium)
    super
    @trivium = trivium
    @winners = trivium.winners
  end

  def score(team)
    team.submissions_for(@trivium).last&.score || 0
  end
end
