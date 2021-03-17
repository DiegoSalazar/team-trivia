# frozen_string_literal: true

class TriviaListComponent < ViewComponent::Base
  include Pagy::Frontend

  def initialize(trivia, pagy)
    super
    @trivia = trivia
    @pagy = pagy
  end

  def render?
    @trivia.present?
  end
end
