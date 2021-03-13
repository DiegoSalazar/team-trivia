# frozen_string_literal: true

class QuestionReflex < ApplicationReflex
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

  def new
    @trivium = Trivium.find element.dataset.trivium_id
    @question = @trivium.questions.build
  end

  def add_answer
    @question = Question.new question_params
    @trivium = @question.trivium
    @question.answers.build
  end

  def cancel
    @question = nil
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

  def question_params
    params.require(:question).permit \
      :body,
      :trivium_id,
      :question_type,
      answers_attributes: %i[value]
  end
end
