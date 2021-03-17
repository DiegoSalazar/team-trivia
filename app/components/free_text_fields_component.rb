# frozen_string_literal: true

class FreeTextFieldsComponent < ViewComponent::Base
  def initialize(guess_form)
    super
    @guess_form = guess_form
  end
end
