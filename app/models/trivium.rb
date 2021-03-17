# frozen_string_literal: true

class Trivium < ApplicationRecord
  belongs_to :player
  has_many :questions
  has_many :guesses
  has_many :submissions
  has_many :winners, -> {
    order(score: :desc).limit 3
  }, through: :submissions, source: :team

  validates :title, presence: true
  validates :body, presence: { message: 'should include a hint' }
  validates :game_starts_at, :game_ends_at, format: {
    # Date time format: YYYY-MM-DD HH:MM:SS
    with: %r/\d{4}[-|\/]\d{2}[-|\/]\d{2}\s\d{2}:\d{2}:\d{2}/
  }
  validate :starts_before_it_ends

  scope :past, -> { recent.where 'game_ends_at < ?', Time.now }
  scope :recent, -> { order game_ends_at: :desc }
  scope :series, -> { order :game_starts_at }
  scope :started, -> { series.where 'game_starts_at < ?', Time.now }
  scope :happening, -> { started.where 'game_ends_at > ?', Time.now }
  scope :upcoming, -> { series.where 'game_starts_at > ?', Time.now }

  def self.active
    happening.first
  end

  def self.up_next
    upcoming.first
  end

  def question_number(question)
    i = question_ids.index(question.id)
    i ? i + 1 : -1
  end

  def first_unrevealed_question
    questions.detect { |q| q.unrevealed? && !q.active? }
  end

  def active_question
    questions.find &:active?
  end

  def all_questions_revealed?
    questions.all?(&:answer_revealed?)
  end

  def next_trivium
    return if game_ends_at.blank?

    Trivium
      .series
      .where('game_starts_at > ?', game_ends_at)
      .first
  end

  def following_trivia
    scope = self.class.series.limit 10
    return scope if game_ends_at.blank?

    scope.where 'game_starts_at > ?', game_ends_at.in_time_zone(Time.zone)
  end

  def upcoming?
    return false if game_starts_at.blank?

    Time.zone.now.to_datetime <= game_starts_at.in_time_zone(Time.zone)
  end

  def started?
    return false if game_starts_at.blank?

    Time.zone.now.to_datetime >= game_starts_at.in_time_zone(Time.zone)
  end

  def active?
    started? && !ended?
  end

  def ended?
    return false if game_ends_at.blank?

    Time.zone.now.to_datetime >= game_ends_at.in_time_zone(Time.zone)
  end

  def full?
    questions.count >= max_questions
  end

  def questions_by(player)
    questions.where player_id: player.id
  end

  private

  def starts_before_it_ends
    return true if seconds_apart >= 60

    errors.add :base, 'game must end at least a minute after it starts'
  end

  def seconds_apart
    game_ends_at.to_i - game_starts_at.to_i
  end
end
