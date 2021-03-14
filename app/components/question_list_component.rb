# frozen_string_literal: true

class QuestionListComponent < ViewComponent::Base
  include TriviumQuestions

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

  def button_data(question)
    return {} if @trivium.ended?

    {
      reflex: 'click->play#select_question',
      question_id: question.id,
      trivium_id: @trivium.id
    }
  end

  private

  def active?(question)
    !@trivium.ended? && question.id == @question.id
  end
end
