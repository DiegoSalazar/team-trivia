# frozen_string_literal: true

class Guess < ApplicationRecord
  acts_as_votable

  belongs_to :question_template
  belongs_to :submission, optional: true
  has_one :team_message

  def accepted?
    cached_votes_total > 0
  end

  def question_number(trivium)
    trivium.question_template_ids.index(question_template_id) + 1
  end
end
