# frozen_string_literal: true

class QuestionTemplateReflex < ApplicationReflex
  def new
    form = controller.render CreateQuestionTemplateComponent.new QuestionTemplate.new
    cable_ready[current_player.chat_channel].inner_html \
      selector: '#new-question',
      focus_selector: '#question_template_body',
      html: form
    cable_ready.broadcast
    morph :nothing
  end

  def cancel
    @question_template = nil
  end
end
