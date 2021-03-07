# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  def ===(guess)
    value.downcase == guess.value.downcase
  end
end
