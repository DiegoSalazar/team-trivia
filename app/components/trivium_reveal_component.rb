# frozen_string_literal: true

class TriviumRevealComponent < ViewComponent::Base
  def initialize(trivium, reveal_status, current_question_revealed)
    super
    @trivium = trivium
    @questions = trivium.question_templates.recent
    @reveal_status = reveal_status
    @current_question_revealed = current_question_revealed
  end

  def reveal_next_question_btn
    return if all_questions_revealed?

    button_tag \
      'Next Question',
      class: 'btn btn-success',
      data: {
        reflex: 'click->QuestionTemplate#reveal',
        trivium_id: @trivium.id
      }
  end

  def all_questions_revealed?
    @reveal_status.all? { |_, v| v }
  end
end
