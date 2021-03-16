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
    @question&.persisted? ? edit_question_title : 'New Question'
  end

  def submit_button_text
    action = @question&.persisted? ? 'Save' : 'Create'
    "#{action} Question"
  end

  def delete_button
    return if @question&.new_record?

    link_to 'Delete', trivium_question_path(@trivium, @question), class: 'btn btn-sm btn-danger', tabindex: -1, data: { method: :delete, confirm: 'Are you sure?', disable_with: 'Deleting...' }
  end

  private

  def edit_question_title
    "Question #{badge @question.question_index}".html_safe
  end

  def badge(text, style = 'info')
    content_tag :span, text, class: "badge badge-pill badge-#{style}"
  end
end
