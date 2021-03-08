# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :trivium
  has_many :answers
  has_many :guesses

  scope :recent, -> { order created_at: :desc }

  def aggregated_guesses
    guesses
      .select('COUNT(*) AS same_count, *')
      .group('LOWER(value)')
      .order 'LOWER(value)'
  end

  def num_accepted_guesses
    guesses.accepted.count
  end

  def accepted_guess
    guesses.by_most_votes.first
  end

  def correct?(guess)
    guess.question.answers.any? { |answer| guess === answer }
  end
end
