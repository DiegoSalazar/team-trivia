# frozen_string_literal: true

class GuessedByComponent < ViewComponent::Base
  include PlayerGuesses

  attr_reader :player, :guess

  def initialize(message, player, trivium)
    super
    @message = message
    @player = player
    @trivium = trivium
    @guess = message.guess
    @question_number = @guess.question_number @trivium
    @question_body = @guess.question_body
  end

  def question_badge
    "Q ##@question_number"
  end

  def question_title
    "Question ##@question_number: #@question_body"
  end

  def badge_class
    klass = 'badge-danger'
    klass = 'badge-light' if my_guess_accepted?
    klass = 'badge-dark' if their_guess_accepted?
    klass += ' my-guess' if sender?
    klass
  end
end
