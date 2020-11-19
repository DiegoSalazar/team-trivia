# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :joins
  has_many :players, through: :joins
end
