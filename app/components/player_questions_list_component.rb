# frozen_string_literal: true

class PlayerQuestionsListComponent < ViewComponent::Base
  include TriviumQuestions

  def initialize(trivium, questions)
    super
    @trivium = trivium
    @questions = questions
  end

  def render?
    @questions.present?
  end
end
