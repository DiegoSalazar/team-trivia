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
    c += ' active' if question.id == @question.id
    c
  end
end
