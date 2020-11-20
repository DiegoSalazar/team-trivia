# frozen_string_literal: true

class Trivium < ApplicationRecord
  has_many :questions

  validates :title, :body, presence: true
end
