# frozen_string_literal: true

class PlayerQuestionsListComponent < ViewComponent::Base
  include TriviumQuestions

  def initialize(trivium, questions, pagy)
    super
    @trivium = trivium
    @questions = questions
    @pagy = pagy
  end

  def render?
    @questions.present?
  end

  def edit_question_button(question)
    return if @trivium.started?

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
