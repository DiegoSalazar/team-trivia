# frozen_string_literal: true

class Guess < ApplicationRecord
  belongs_to :question_template
  belongs_to :submission
end
