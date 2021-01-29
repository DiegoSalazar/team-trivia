# frozen_string_literal: true

class Trivium < ApplicationRecord
  has_many :trivium_questions
  has_many :question_templates, through: :trivium_questions
  has_many :questions

  validates :title, presence: true
  validates :body, presence: { message: 'should include a hint' }
  validates :game_starts_at, :game_ends_at, format: {
    # Date time format: YYYY-MM-DD HH:MM:SS
    with: /\d{4}[-|\/]\d{2}[-|\/]\d{2}\s\d{2}:\d{2}:\d{2}/
  }
  validate :starts_before_it_ends

  scope :recent, -> { order(game_ends_at: :desc) }
  # TODO: write logic to get current started game according to the game times
  scope :active, -> { last }

  def seconds_apart
    game_ends_at.to_i - game_starts_at.to_i
  end

  def question_index(question)
    i = question_template_ids.index(question.id)
    return -1 if i.nil?

    i.succ
  end

  private

  def starts_before_it_ends
    return true if seconds_apart > 60
    errors.add :base, 'game must start at least a minute before it ends'
  end
end
