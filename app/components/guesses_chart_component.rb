# frozen_string_literal: true

class GuessesChartComponent < ViewComponent::Base
  def initialize(question)
    super
    @question = question
  end
end
