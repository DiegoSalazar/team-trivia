# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :trivium
  belongs_to :player
  has_many :guesses
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :body, presence: true
  scope :recent, -> { order created_at: :desc }

  enum question_type: %i[free_text multiple_choice]
  enum revealed: %i[unrevealed question_revealed answer_revealed]

  CorrectAnswer = Struct.new 'CorrectAnswer', :value, :same_count

  def grouped_guesses
    g = guesses.order 'LOWER(VALUE)'
    g += [CorrectAnswer.new(answer_value, 0)] if g.none?(&:correct?)
    g.group_by { |guess| guess.value.downcase }
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

  def active!
    update active: true
  end

  def inactive!
    update active: false
  end

  def correct?(guess)
    answers.any? { |answer| guess === answer }
  end

  def answer_value
    best_answer&.value
  end

  def answer_points
    best_answer&.points
  end

  def best_answer
    answers.order(:points).last
  end

  def points_for(guess)
    return 0 unless correct? guess

    answers.find { |a| a === guess }&.points
  end

  def question_number
    trivium.question_number self
  end
end
