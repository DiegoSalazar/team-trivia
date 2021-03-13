# frozen_string_literal: true

class AnswerFieldsComponent < ViewComponent::Base
  def initialize(answers, question_form)
    super
    @answers = answers
    @question_form = question_form
  end

  def add_question_button
    button_tag \
      'Add',
      class: 'btn btn-primary btn-sm',
      data: {
        reflex: 'click->Question#add_answer'
      }
  end
end
