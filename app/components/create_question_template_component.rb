# frozen_string_literal: true

class CreateQuestionTemplateComponent < ViewComponent::Base
  def initialize(question_template)
    @question_template = question_template
  end

  def render_form?
    @question_template.present?
  end
end
