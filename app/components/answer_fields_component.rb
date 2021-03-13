# frozen_string_literal: true

class AnswerFieldsComponent < ViewComponent::Base
  def initialize(answers, question_form, tab_start = 0)
    super
    @answers = answers
    @question_form = question_form
    @tab = tab_start
  end

  def add_question_button
    link_to nil, data: { reflex: 'click->Question#add_answer' }, tabindex: @tab + @answers.size do
      helpers.icon 'plus-square-fill', class: 'text-info'
    end
  end
end
