# frozen_string_literal: true

class QuestionRevealComponent < ViewComponent::Base
  def initialize(question, question_index)
    super
    @question = question
    @question_index = question_index
  end
end
