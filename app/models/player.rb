# frozen_string_literal: true

class Player < ApplicationRecord
  has_many :joins
  has_many :teams, through: :joins
end
