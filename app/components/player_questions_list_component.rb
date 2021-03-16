# frozen_string_literal: true

class PlayerQuestionsListComponent < ViewComponent::Base
  include TriviumQuestions

  def initialize(trivium, questions)
    super
    @trivium = trivium
    @questions = questions
  end

  def render?
    @questions.present?
  end

  def edit_question_button(question)
    return unless @trivium.upcoming?

    button_tag \
      helpers.icon('pencil'),
      data: {
        reflex: 'click->Question#edit',
        id: question.id,
        trivium_id: @trivium.id
      },
      class: 'btn btn-sm btn-default'
  end
end
