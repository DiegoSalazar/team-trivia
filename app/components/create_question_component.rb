# frozen_string_literal: true

class CreateQuestionComponent < ViewComponent::Base
  def initialize(trivium, question, errors = [])
    super
    @trivium = trivium
    @question = question
    @errors = errors
  end

  def render?
    !@trivium.started? && !@trivium.full?
  end

  def new_question_button
    return if @question.present?

    button_tag \
      'New Question',
      class: 'btn btn-primary btn-block mb-3',
      data: {
        reflex: 'click->Question#new',
        trivium_id: @trivium.id
      }
  end
end
