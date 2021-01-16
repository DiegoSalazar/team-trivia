# frozen_string_literal: true

class VoteComponent < ViewComponent::Base
  def initialize(player, guess)
    @player = player
    @guess = guess
  end
end
