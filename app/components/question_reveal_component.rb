# frozen_string_literal: true

class QuestionRevealComponent < ViewComponent::Base
  include QuestionHelper

  def initialize(question, question_number)
    super
    @question = question
    @question_number = question_number
  end

  def reveal_status(question)
    status = []
    status << 'revealed' unless question.unrevealed?
    status << 'active' if question.active?
    status.join ' '
  end

  def status_text
    s = ['Correct Guesses / Total Guesses.']
    s << 'No accepted Guess for this Question.' unless guesses_voted_on?
    s.join ' '
  end
end
