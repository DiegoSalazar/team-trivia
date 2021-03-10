# frozen_string_literal: true

class QuestionStatusComponent < ViewComponent::Base
  attr_reader :title

  def initialize(question, num:, denom:, title:, active: false)
    super
    @question = question
    @num = num
    @denom = denom
    @active = active
    @title = title
  end

  def id
    "#{dom_id @question}-status"
  end

  def css_class
    c = 'badge-primary'
    c = 'badge-light' if @active
    c = 'badge-success' if @question.num_accepted_guesses.positive?
    c
  end

  def status
    "#{@num} / #{@denom}"
  end
end
