# frozen_string_literal: true

class QuestionFormComponent < ViewComponent::Base
  def initialize(trivium, question)
    super
    @trivium = trivium
    @question = question
  end

  def render?
    @question.present?
  end

  def title
    @question.persisted? ? edit_question_title : 'New Question'
  end

  def create_button(form, tabindex:)
    form.submit \
      @question.persisted? ? 'Save' : 'Create',
      class: 'btn btn-sm btn-success flex-grow-1',
      disable_with: 'Creating...',
      tabindex: tabindex
  end

  def cancel_button(tabindex:)
    return if @question.new_record?

    link_to \
      'Cancel',
      new_trivium_question_path(@trivium),
      class: 'btn btn-sm btn-secondary flex-grow-0',
      tabindex: tabindex
  end

  def delete_button
    return if @question.new_record?

    link_to \
      'Delete',
      trivium_question_path(@trivium, @question),
      class: 'btn btn-sm btn-danger flex-grow-0',
      tabindex: -1,
      data: {
        method: :delete,
        disable_with: 'Deleting...'
      }
  end

  private

  def edit_question_title
    "Question #{badge @question.question_number}".html_safe
  end

  def badge(text, style = 'info')
    content_tag :span, text, class: "badge badge-pill badge-#{style}"
  end
end
