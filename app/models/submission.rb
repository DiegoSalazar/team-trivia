# frozen_string_literal: true

class Submission < ApplicationRecord
  belongs_to :trivia
  belongs_to :team
end