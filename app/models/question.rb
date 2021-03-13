# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :trivium
  belongs_to :player
  has_many :guesses
  has_many :answers
  accepts_nested_attributes_for :answers

  scope :recent, -> { order created_at: :desc }
  enum revealed: %i[unrevealed question_revealed answer_revealed]
  validates :body, presence: true

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

  def correct_guesses
    guesses.select(&:correct?)
  end

  def correct?(guess)
    answers.any? { |answer| guess === answer }
  end

  def answer_value
    answers.first&.value
  end

  def points_for(guess)
    return 0 unless correct? guess

    answers.find { |a| a === guess }&.points
  end
end
