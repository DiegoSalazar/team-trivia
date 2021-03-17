# frozen_string_literal: true

class PlayReflex < ApplicationReflex
  def select_question
    @current_trivium = Trivium.find element.dataset.trivium_id
    @current_question = @current_trivium.questions.find element.dataset.question_id
    controller.flash[:guess] = true
  end
end
