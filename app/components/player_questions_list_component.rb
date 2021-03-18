# frozen_string_literal: true

class PlayerQuestionsListComponent < ViewComponent::Base
  include Pagy::Frontend
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

  def question_type_icon(question)
    icon = 'list-task'
    icon = 'card-text' if question.free_text?
    content_tag \
      :span,
      helpers.icon(icon, class: 'mr-2'),
      title: question.question_type.titleize
  end

  def edit_question_button(question)
    return if @trivium.started?

    button_tag \
      helpers.icon('pencil-fill'),
      class: 'btn btn-sm btn-default',
      data: {
        reflex: 'click->Question#edit',
        id: question.id,
        trivium_id: @trivium.id
      }
  end
end
