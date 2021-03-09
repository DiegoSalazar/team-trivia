# frozen_string_literal: true

class TriviumRevealComponent < ViewComponent::Base
  def initialize(trivium)
    super
    @trivium = trivium
    @questions = trivium.questions.recent
  end

  def reveal_next_question_btn
    return if all_questions_revealed?

    button_tag \
      button_text,
      id: 'next-question-btn',
      class: 'btn btn-success',
      data: {
        reflex: 'click->Question#reveal',
        trivium_id: @trivium.id
      }
  end

  def all_questions_revealed?
    @trivium.all_questions_revealed?
  end

  def button_text
    text = 'Next Question'
    text = 'Reveal Answer' if @trivium.active_question&.question_revealed?
    text
  end
end
