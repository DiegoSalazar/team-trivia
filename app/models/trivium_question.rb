# frozen_string_literal: true

class TriviumQuestion < ApplicationRecord
  belongs_to :trivium, dependent: :destroy
  belongs_to :question

  # has_many :submission           # the idea is each submission should have the team's answer and also team id (for scoring purposes)
end
