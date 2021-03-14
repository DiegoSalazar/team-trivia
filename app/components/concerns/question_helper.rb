# frozen_string_literal: true

module QuestionHelper
  private

  def guesses_voted_on?
    @question.num_accepted_guesses.positive?
  end
end
