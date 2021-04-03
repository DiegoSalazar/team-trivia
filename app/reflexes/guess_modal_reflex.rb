# frozen_string_literal: true

class GuessModalReflex < ModalReflex
  def close
    super
    @trivium = Trivium.find element.dataset.trivium_id
    @current_question = @trivium.questions.find element.dataset.question_id

    controller.flash[:close_guess_modal] = true
    cable_ready.push_state url: close_path
  end

  private

  def close_path
    controller.play_team_trivium_path current_player.current_team, @trivium
  end
end
