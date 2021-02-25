# frozen_string_literal: true

class QuestionListComponent < ViewComponent::Base
  def initialize(questions, question, trivium)
    super
    @questions = questions
    @question = question
    @trivium = trivium
  end

  def button_class(question)
    c = 'list-group-item list-group-item-action'
    c += ' active' if active? question
    c
  end

  def question_index(question)
    @trivium.question_index question
  end

  private

  def active?(question)
    question.id == @question.id
  end
end
