# frozen_string_literal: true

class Guess < ApplicationRecord
  belongs_to :question_template
  belongs_to :submission, optional: true
  has_many :team_messages
end
