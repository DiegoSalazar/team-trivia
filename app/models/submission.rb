# frozen_string_literal: true

class Submission < ApplicationRecord
  belongs_to :trivium
  belongs_to :team
  has_many :guesses

  def guesses_of(question_id)
    guesses.select { |guess| guess.question_id == question_id }
  end
end
