# frozen_string_literal: true

class TriviaListComponent < ViewComponent::Base
  def initialize(trivia)
    super
    @trivia = trivia
  end

  def render?
    @trivia.present?
  end
end
