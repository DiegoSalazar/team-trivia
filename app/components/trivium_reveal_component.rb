# frozen_string_literal: true

class TriviumRevealComponent < ViewComponent::Base
  def initialize(trivium)
    super
    @trivium = trivium
    @questions = trivium.questions.recent
  end

  def title
    return if all_questions_revealed?

    content_tag :h2, 'Question Reveal'
  end

  def reveal_button
    return if all_questions_revealed?

    button_tag \
      button_text,
      id: 'next-question-btn',
      class: "btn btn-#{button_class}",
      data: {
        reflex: 'click->Question#reveal',
        trivium_id: @trivium.id
      }
  end

  def winners
    return unless all_questions_revealed?

    render TriviumWinnersComponent.new @trivium
  end

  def all_questions_revealed?
    @trivium.all_questions_revealed?
  end

  def button_text
    text = 'Next Question'
    text = 'Reveal Answer' if @trivium.active_question&.question_revealed?
    text
  end

  def button_class
    klass = 'success'
    klass = 'danger' if @trivium.active_question&.question_revealed?
    klass
  end
end
