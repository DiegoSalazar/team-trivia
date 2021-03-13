# frozen_string_literal: true

class QuestionFormComponent < ViewComponent::Base
  def initialize(question)
    super
    @question = question
  end

  def render?
    @question.present?
  end
end
