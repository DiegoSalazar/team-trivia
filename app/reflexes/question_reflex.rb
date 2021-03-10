# frozen_string_literal: true

class QuestionReflex < ApplicationReflex
  def new
    form = controller.render CreateQuestionComponent.new Question.new
    cable_ready[current_player.chat_channel].inner_html \
      selector: '#new-question',
      focus_selector: '#question_body',
      html: form
    cable_ready.broadcast
    morph :nothing
  end

  def reveal
    trivium = Trivium.find element.dataset.trivium_id
    next_question = trivium.first_unrevealed_question
    active_question = trivium.active_question

    if trivium.all_questions_revealed?
      active_question.update! active: false
      return
    end

    if next_question && active_question.nil?
      reveal_and_mark_active! next_question

    elsif active_question.question_revealed?
      cable_ready['trivium_reveal'].add_css_class \
        selector: "#question_#{active_question.id} [data-guess-value='#{active_question.answer_value}']",
        name: 'correct'
      active_question.answer_revealed!

      if trivium.all_questions_revealed?
        set_next_button 'Reveal Winners', %w[btn-info btn-danger]
      else
        set_next_button 'Next Question', %w[btn-success btn-danger]
      end

    elsif active_question.answer_revealed?
      cable_ready['trivium_reveal'].remove_css_class \
        selector: "#question_#{active_question.id}",
        name: 'active'
      active_question.update! active: false
      reveal_and_mark_active! next_question
    end

    cable_ready.broadcast
    morph :nothing
  end

  private

  def reveal_and_mark_active!(question)
    %w[revealed active].each do |klass|
      cable_ready['trivium_reveal'].add_css_class \
        selector: "#question_#{question.id}",
        name: klass
    end

    question.question_revealed!
    question.update! active: true
    set_next_button 'Reveal Answer', %w[btn-danger btn-success]
  end

  def set_next_button(text, (add_class, remove_class))
    cable_ready['trivium_reveal'].text_content \
      selector: '#next-question-btn',
      text: text
    cable_ready['trivium_reveal'].add_css_class \
      selector: '#next-question-btn',
      name: add_class
    cable_ready['trivium_reveal'].remove_css_class \
      selector: '#next-question-btn',
      name: remove_class
  end

  def cancel
    @question = nil
  end
end
