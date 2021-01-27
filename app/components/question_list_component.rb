# frozen_string_literal: true

class QuestionListComponent < ViewComponent::Base
  def initialize(questions, question, trivium)
    super
    @questions = questions
    @question = question
    @question_index = trivium.question_index question
  end

  def button_class(question)
    c = 'list-group-item list-group-item-action'
    c += ' active' if active? question
    c
  end

  def question_status(question)
    "#{question.guesses.count} / #{question.num_accepted_guesses}"
  end

  def question_status_class(question)
    c = 'badge-primary'
    c = 'badge-light' if active? question
    c = 'badge-success' if question.num_accepted_guesses > 0
    c
  end

  private

  def active?(question)
    question.id == @question.id
  end
end
