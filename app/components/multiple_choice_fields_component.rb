# frozen_string_literal: true

class MultipleChoiceFieldsComponent < ViewComponent::Base
  def initialize(choices, guess_form)
    super
    @choices = choices
    @guess_form = guess_form
  end
end
