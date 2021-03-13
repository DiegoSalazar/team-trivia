# frozen_string_literal: true

class CreateQuestionComponent < ViewComponent::Base
  def initialize(trivium, question, notice = nil, errors = [])
    super
    @trivium = trivium
    @question = question
    @notice = notice
    @errors = errors
  end

  def notice
    return unless @notice

    content_tag :div, @notice, class: 'alert alert-success'
  end

  def new_question_button
    return if @question.present? || @trivium.full?

    button_tag \
      'New Question',
      class: 'btn btn-primary btn-block mb-3',
      data: {
        reflex: 'click->Question#new',
        trivium_id: @trivium.id
      }
  end
end
