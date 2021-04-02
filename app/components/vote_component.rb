# frozen_string_literal: true

class VoteComponent < ViewComponent::Base
  def initialize(player, guess, trivium)
    super
    @player = player
    @guess = guess
    @trivium = trivium
  end

  def link_class
    c = %w[upvote badge rounded-pill]
    c << 'active' if @player.voted_for? @guess
    c += %w[border shadow] unless @player.voted_for? @guess
    c.join ' '
  end

  def disabled?
    @guess.accepted?
  end
end
