# frozen_string_literal: true

class TriviumQuestion < ApplicationRecord
  belongs_to :trivium
  references :question_template # same as belong_to but semantics wise references makes more sense

  # has_many :submission           # the idea is each submission should have the team's answer and also team id (for scoring purposes)
end
