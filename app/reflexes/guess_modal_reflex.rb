# frozen_string_literal: true

class GuessModalReflex < ModalReflex
  def close
    @trivium = Trivium.find element.dataset.trivium_id
    @current_question = @trivium.questions.find element.dataset.question_id
    controller.flash[:close_guess_modal] = true
    super
  end
end
