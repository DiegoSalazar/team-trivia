# frozen_string_literal: true

class Guess < ApplicationRecord
  acts_as_votable

  belongs_to :player
  belongs_to :team
  belongs_to :trivium
  belongs_to :question
  belongs_to :submission, optional: true
  has_one :team_message

  scope :by_most_votes, -> { order cached_votes_up: :desc }
  scope :accepted, -> { where 'cached_votes_up > 0' }

  def ===(answer)
    value.downcase == answer.value.downcase
  end

  def accepted?
    cached_votes_total.positive?
  end

  def correct?
    question&.correct? self
  end

  def points
    question&.points_for(self) || 0
  end

  def question_number(trivium)
    i = trivium.question_ids.index(question_id)
    i + 1 if i
  end

  def question_body
    question.body
  end
end
