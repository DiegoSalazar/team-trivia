# frozen_string_literal: true

class GuessModalReflex < ModalReflex
  def close
    super
    @trivium = Trivium.find element.dataset.trivium_id
    @current_question = @trivium.questions.find element.dataset.question_id
  end
end
