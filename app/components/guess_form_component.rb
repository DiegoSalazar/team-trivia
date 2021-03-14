# frozen_string_literal: true

class GuessFormComponent < ViewComponent::Base
  def initialize(guess, show: true)
    super
    @guess = guess
    @show = show
  end

  def render?
    @show
  end
end
