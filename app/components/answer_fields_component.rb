# frozen_string_literal: true

class AnswerFieldsComponent < ViewComponent::Base
  def initialize(answers, question_form, tabindex: 0)
    super
    @answers = answers
    @question_form = question_form
    @tab = tabindex + @answers.size
  end

  def add_answer_button
    link_to \
      helpers.icon('plus-circle-fill', class: 'text-secondary'),
      nil,
      title: 'Add Answer or Choice',
      tabindex: @tab,
      data: {
        reflex: 'click->Question#add_answer',
        question_id: @question_form.object.id
      }
  end

  def remove_answer_button(answer, i)
    link_to \
      helpers.icon('x-circle', class: 'text-danger mt-2'),
      nil,
      title: 'Remove this Answer',
      role: 'button',
      data: {
        reflex: 'click->Question#remove_answer',
        id: answer.question_id,
        answer_id: answer.id,
        answer_index: i
      }
  end
end
