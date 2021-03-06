# frozen_string_literal: true

class Guess < ApplicationRecord
  acts_as_votable

  belongs_to :player
  belongs_to :team
  belongs_to :trivium
  belongs_to :question_template
  belongs_to :submission, optional: true
  has_one :team_message

  scope :by_most_votes, -> { order cached_votes_up: :desc }
  scope :accepted, -> { where 'cached_votes_up > 0' }

  def similarity_ratio
    (same_count_percent_of(question_template.guesses.count) / 10.0).ceil
  end

  def same_count_percent_of(num)
    (same_count / num.to_f * 100).to_i
  rescue NameError => e
    raise e, 'Can only use this method on an aggregated_guess'
  end

  def accepted?
    cached_votes_total.positive?
  end

  def question_number(trivium)
    i = trivium.question_template_ids.index(question_template_id)
    i + 1 if i
  end

  def question_body
    question_template.body
  end
end
