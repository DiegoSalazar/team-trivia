# frozen_string_literal: true

class QuestionRevealComponent < ViewComponent::Base
  def initialize(question, question_index, reveal_status, current_question_revealed)
    super
    @question = question
    @question_index = question_index
    @reveal_status = reveal_status
    @current_question_revealed = current_question_revealed
  end

  def reveal_status(question)
    status = []
    status << 'revealed' if @reveal_status[question.id]
    status << 'active' if active? question
    status.join ' '
  end

  def active?(question)
    @current_question_revealed == question.id
  end
end
