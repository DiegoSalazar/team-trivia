# frozen_string_literal: true

class GuessesChartComponent < ViewComponent::Base
  def initialize(question)
    super
    @question = question
    @guesses_count = question.guesses.count
  end

  def percent_of_similar_guesses(guess)
    return '&nbsp;'.html_safe if guess.is_a? Question::CorrectAnswer

    number_to_percentage guess.same_count_percent_of(@guesses_count), precision: 1
  end

  def height_percent(guess)
    "height: #{guess.similarity_ratio}%;"
  end

  def answer_status(guess)
    'correct' if @question.answer_revealed? && @question.correct?(guess)
  end
end
