# frozen_string_literal: true

class CreateQuestionComponent < ViewComponent::Base
  def initialize(question)
    @question = question
  end

  def render_form?
    @question.present?
  end
end
