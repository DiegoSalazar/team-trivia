# frozen_string_literal: true

class CreateQuestionComponent < ViewComponent::Base
  def initialize(trivium, question, errors = [])
    super
    @trivium = trivium
    @question = question
    @errors = errors
  end

  def render?
    !@trivium.started? && !@trivium.full?
  end
end
