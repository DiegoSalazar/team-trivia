# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :joins
  has_many :players, through: :joins
  has_many :team_messages
  has_many :guesses
  has_many :submissions

  def team_messages_from(trivium)
    team_messages.where trivium: trivium
  end

  def chat_room
    "team-#{id}"
  end

  def chat_title
    "Team #{name.titleize} Chat"
  end
end
