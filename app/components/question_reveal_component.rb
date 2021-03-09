# frozen_string_literal: true

class QuestionRevealComponent < ViewComponent::Base
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
end
