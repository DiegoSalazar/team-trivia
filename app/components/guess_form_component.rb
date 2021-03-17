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

  def modal_params
    {
      reflex: 'click->GuessModal#close',
      question_id: @guess.question_id,
      trivium_id: @guess.trivium_id
    }
  end
end
