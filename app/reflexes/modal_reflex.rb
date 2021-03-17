# frozen_string_literal: true

class ModalReflex < ApplicationReflex
  def close
    controller.flash.delete element.dataset.modal.to_sym
  end
end
