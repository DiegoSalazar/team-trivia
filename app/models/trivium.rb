# frozen_string_literal: true

class Trivium < ApplicationRecord
  has_many :trivium_questions
  has_many :question_templates, through: :trivium_questions
  has_many :guesses

  validates :title, presence: true
  validates :body, presence: { message: 'should include a hint' }
  validates :game_starts_at, :game_ends_at, format: {
    # Date time format: YYYY-MM-DD HH:MM:SS
    with: %r/\d{4}[-|\/]\d{2}[-|\/]\d{2}\s\d{2}:\d{2}:\d{2}/
  }
  validate :starts_before_it_ends

  scope :past, -> { recent.where 'game_ends_at < ?', Time.zone.now }
  scope :recent, -> { order game_ends_at: :desc }
  scope :series, -> { order :game_starts_at }
  scope :upcoming, -> { series.where 'game_starts_at > ?', Time.zone.now }

  def self.active
    upcoming.first
  end

  def seconds_apart
    game_ends_at.to_i - game_starts_at.to_i
  end

  def question_index(question)
    i = question_template_ids.index(question.id)
    i ? i + 1 : -1
  end

  private

  def starts_before_it_ends
    return true if seconds_apart > 60

    errors.add :base, 'game must start at least a minute before it ends'
  end
end
