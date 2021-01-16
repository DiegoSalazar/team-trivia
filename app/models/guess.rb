# frozen_string_literal: true

class Guess < ApplicationRecord
  belongs_to :question_template
  belongs_to :submission, optional: true
  has_many :team_messages

  def question_number(trivium)
    trivium.question_template_ids.index(question_template_id) + 1
  end
end
