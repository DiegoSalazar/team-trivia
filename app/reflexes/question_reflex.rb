# frozen_string_literal: true

class QuestionReflex < ApplicationReflex
  def reveal
    trivium = Trivium.find element.dataset.trivium_id
    next_question = trivium.first_unrevealed_question
    active_question = trivium.active_question

    if trivium.all_questions_revealed?
      active_question.inactive!
      return
    end

    if next_question && active_question.nil?
      reveal_and_mark_active! next_question

    elsif active_question&.question_revealed?
      cable_ready['trivium_reveal'].add_css_class \
        selector: "#question_#{active_question.id} [data-guess-value='#{active_question.answer_value.parameterize}']",
        name: 'correct'
      active_question.answer_revealed!

      if trivium.all_questions_revealed?
        set_next_button 'Reveal Winners', %w[btn-info btn-danger]
      else
        set_next_button 'Next Question', %w[btn-success btn-danger]
      end

    elsif active_question&.answer_revealed?
      cable_ready['trivium_reveal'].remove_css_class \
        selector: "#question_#{active_question.id}",
        name: 'active'
      active_question.inactive!
      reveal_and_mark_active! next_question
    end

    cable_ready['trivium_reveal'].broadcast
    morph :nothing
  end

  def add_answer
    @question = Question.new question_params
    @trivium = @question.trivium
    @question = @trivium.questions.find element.dataset.question_id if element.dataset.question_id
    @question.answers.build
  end

  def remove_answer
    answer_id = element.dataset.id
    answer_index = element.dataset.answer_index

    if answer_id.blank?
      @question = Question.new
      remove_answer_at answer_index

      morph :nothing
      cable_ready.broadcast
      return
    end

    @question = current_player.questions.find answer_id

    if element.dataset.answer_id.blank?
      remove_answer_at answer_index

      cable_ready.broadcast
      morph :nothing
      return
    end

    answer = @question.answers.find element.dataset.answer_id
    return morph :nothing if answer.nil?

    replace_answer_with_delete_field answer_index
    morph :nothing
    cable_ready.broadcast
  end

  private

  def remove_answer_at(index)
    cable_ready
      .remove(selector: "[data-answer-index='#{index}']")
      .remove selector: "#question_answers_attributes_#{index}_id"
  end

  def replace_answer_with_delete_field(index)
    cable_ready.outer_html \
      selector: "[data-answer-index='#{index}']",
      html: <<-HTML.strip_heredoc
        <input
          name="question[answers_attributes][#{index}][_destroy]"
          value="1"
          type="hidden"
        />
      HTML
  end

  def reveal_and_mark_active!(question)
    %w[revealed active].each do |klass|
      cable_ready['trivium_reveal'].add_css_class \
        selector: "#question_#{question.id}",
        name: klass
    end

    question.question_revealed!
    question.active!
    set_next_button 'Reveal Answer', %w[btn-danger btn-success]
  end

  def set_next_button(text, (add_class, remove_class))
    cable_ready['trivium_reveal']
      .text_content(
        selector: '#next-question-btn',
        text: text
      )
      .add_css_class(
        selector: '#next-question-btn',
        name: add_class
      )
      .remove_css_class \
        selector: '#next-question-btn',
        name: remove_class
  end

  def question_params
    params.require(:question).permit \
      :body,
      :trivium_id,
      :question_type,
      answers_attributes: %i[value points]
  rescue => e
    Rails.logger.debug 'question_params'
    Rails.logger.error e
    pq = params[:question]&.to_unsafe_h || {}
    Rails.logger.debug pq
    Rails.logger.debug paramKeys: params.keys
    Rails.logger.debug dataset: element&.dataset
    Rails.logger.debug envKeys: (begin; request.env.keys; rescue => e; e end)
    Rails.logger.debug formData: params['formData']
    qd = element.dataset.question
    Rails.logger.debug questionDataset: qd
    Rails.logger.debug controllerParams: controller.params


    pq
  end
end
