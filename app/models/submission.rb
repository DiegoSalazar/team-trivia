# frozen_string_literal: true

class Submission < ApplicationRecord
  belongs_to :trivium
  belongs_to :team
  has_many :guesses

  def guesses_of(question_template_id)
    guesses.select { |guess| guess.question_template_id == question_template_id }
  end
end
