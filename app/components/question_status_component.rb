# frozen_string_literal: true

class QuestionStatusComponent < ViewComponent::Base
  include QuestionHelper

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
    c = 'badge-success' if guesses_voted_on?
    c
  end

  def status
    "#{@num} / #{@denom}"
  end

  private

  def guesses_voted_on?
    @question.num_accepted_guesses.positive?
  end
end
