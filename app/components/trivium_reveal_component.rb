# frozen_string_literal: true

class TriviumRevealComponent < ViewComponent::Base
  def initialize(trivium)
    super
    @trivium = trivium
    @questions = trivium.question_templates
  end
end
