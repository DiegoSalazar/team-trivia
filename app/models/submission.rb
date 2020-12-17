# frozen_string_literal: true

class Submission < ApplicationRecord
  belongs_to :trivium
  belongs_to :team
end
