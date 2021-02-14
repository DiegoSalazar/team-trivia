# frozen_string_literal: true

class QuestionTemplate < ApplicationRecord
  has_many :answer_templates
  has_many :guesses

  scope :recent, -> { order created_at: :desc }

  # attr_accessor :body
  # attr_accessor :correct_answer
  # attr_accessor :question_type

  def num_accepted_guesses
    guesses.accepted.count
  end

  def accepted_guess
    guesses.by_most_votes.first
  end
end
