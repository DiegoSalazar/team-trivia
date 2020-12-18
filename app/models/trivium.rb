# frozen_string_literal: true

class Trivium < ApplicationRecord
  has_many :questions
  has_many :trivium_questions

  validates :title, :body, presence: true
  validates :game_starts_at, :game_ends_at, format: {
    # Date time format: YYYY-MM-DD HH:MM:SS
    with: /\d{4}[-|\/]\d{2}[-|\/]\d{2}\s\d{2}:\d{2}:\d{2}/
  }
  validate :starts_before_it_ends

  def seconds_apart
    game_ends_at.to_i - game_starts_at.to_i
  end

  private

  def starts_before_it_ends
    return true if seconds_apart > 60
    errors.add :game_starts_at, 'must start at least a minute before it ends'
  end
end
