# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  renders_one :title
  renders_one :footer
  renders_one :close_button

  def initialize(key, reflex = {})
    super
    @key = key
    @reflex = reflex
  end

  def render?
    controller.flash[@key]
  end

  def reflex_data
    {
      reflex: 'click->Modal#close',
      modal: @key
    }.merge @reflex
  end
end
