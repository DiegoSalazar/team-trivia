# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :joins
  has_many :players, through: :joins
  has_many :messages

  def chat_room
    "team-#{id}"
  end
end
