# frozen_string_literal: true

class ContributeQuestionsListComponent < ViewComponent::Base
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
    return if @trivium.started? || @trivium.full?

    link_to \
      helpers.icon('pencil-fill'),
      edit_trivium_question_path(@trivium, question, page_params),
      class: 'text-secondary ml-2'
  end

  private

  def page_params
    controller.params.slice('q-page', 't-page').to_unsafe_h
  end
end
