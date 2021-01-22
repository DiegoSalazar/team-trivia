# frozen_string_literal: true

class VoteComponent < ViewComponent::Base
  attr_reader :player, :guess, :reflex_root

  def initialize(player, guess, reflex_root: '#chat')
    @player = player
    @guess = guess
    @reflex_root = reflex_root
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
