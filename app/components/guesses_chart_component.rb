# frozen_string_literal: true

class GuessesChartComponent < ViewComponent::Base
  def initialize(question)
    super
    @question = question
    @guesses_count = question.guesses.count
  end

  def percent_of_similar_guesses(guesses)
    return '&nbsp;'.html_safe if guesses.first.is_a? Question::CorrectAnswer

    number_to_percentage percent_of_total(guesses), precision: 1
  end

  def height_percent(guesses)
    percent = [10, percent_of_total(guesses)].max
    "height: #{percent}%;"
  end

  def percent_of_total(guesses)
    guesses = guesses.select { |g| g.is_a? Guess }
    return 0 if guesses.empty?

    guesses.count / @question.guesses.count.to_f * 100
  end

  def answer_status(guess)
    'correct' if @question.answer_revealed? && @question.correct?(guess)
  end
end
