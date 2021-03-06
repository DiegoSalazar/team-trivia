# frozen_string_literal: true

class GuessesChartComponent < ViewComponent::Base
  def initialize(question)
    super
    @question = question
    @guesses_count = question.guesses.count
  end

  def percent_of_similar_guesses(guess)
    number_to_percentage guess.same_count_percent_of(@guesses_count), precision: 1
  end

  def value_for_middle_unit(guess, i)
    guess.value if i == guess.similarity_ratio / 2
  end
end
