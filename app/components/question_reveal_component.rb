# frozen_string_literal: true

class QuestionRevealComponent < ViewComponent::Base
  include QuestionHelper

  def initialize(question, question_index)
    super
    @question = question
    @question_index = question_index
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
