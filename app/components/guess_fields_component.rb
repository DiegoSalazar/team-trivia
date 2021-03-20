# frozen_string_literal: true

class GuessFieldsComponent < ViewComponent::Base
  UnknownQuestionType = Class.new KeyError

  def initialize(question, guess_form)
    super
    @question = question
    @type = question.question_type
    @guess_form = guess_form
  end

  def fields_for_question_type
    case @type
    when 'free_text'
      render FreeTextFieldsComponent.new @guess_form
    when 'multiple_choice'
      render MultipleChoiceFieldsComponent.new @question.answers, @guess_form
    else
      raise UnknownQuestionType, @type
    end
  end
end
