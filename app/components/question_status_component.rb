# frozen_string_literal: true

class QuestionStatusComponent < ViewComponent::Base
  attr_reader :title

  def initialize(question, active = false)
    @question = question
    @active = active
    @title = 'Accepted / Guesses'
  end

  def id
    "#{dom_id @question}-status"
  end

  def css_class
    c = 'badge-primary'
    c = 'badge-light' if @active
    c = 'badge-success' if @question.num_accepted_guesses > 0
    c
  end

  def status
    "#{@question.num_accepted_guesses} / #{@question.guesses.count}"
  end
end
