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

  def reveal
    @reveal_status = session[:reveal_status]
    @current_question_revealed = session[:current_question_revealed]
    next_question_id, _ = @reveal_status.detect { |_, v| !v }
    return if next_question_id.nil?

    @reveal_status[next_question_id] = true
    session[:reveal_status] = @reveal_status
    session[:current_question_revealed] = next_question_id

    # Reveal the next question
    %w[revealed active].each do |klass|
      cable_ready['trivium_reveal'].add_css_class \
        selector: "#question_template_#{next_question_id}",
        name: klass
    end

    if @current_question_revealed
      cable_ready['trivium_reveal'].remove_css_class \
        selector: "#question_template_#{@current_question_revealed}",
        name: 'active'
    end

    cable_ready.broadcast
    morph :nothing
  end

  def cancel
    @question_template = nil
  end
end
