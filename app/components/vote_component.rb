# frozen_string_literal: true

class VoteComponent < ViewComponent::Base
  attr_reader :player, :guess

  def initialize(player, guess)
    @player = player
    @guess = guess
  end

  def link_class
    c = %w[upvote badge rounded-pill]
    c << 'active' if @player.voted_for? @guess
    c += %w[border shadow] unless @player.voted_for? @guess
    c.join ' '
  end
end
