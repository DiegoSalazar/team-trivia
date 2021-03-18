# frozen_string_literal: true

class QuestionListComponent < ViewComponent::Base
  include TriviumQuestions

  def initialize(questions, question, trivium, team)
    super
    @questions = questions
    @question = question
    @trivium = trivium
    @team = team
  end

  def button_class(question)
    c = 'list-group-item list-group-item-action'
    c += ' active' if active? question
    c
  end

  private

  def active?(question)
    !@trivium.ended? && question.id == @question.id
  end
end
