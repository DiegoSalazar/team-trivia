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

  def top_guesses_for_all(questions)
    questions.map { |q| top_guess_for q }.compact
  end

  def top_guess_for(question)
    guesses
      .where(question_id: question.id)
      .order(:cached_votes_up)
      .last
  end

  def submissions_for(trivium)
    submissions.where trivium_id: trivium.id
  end

  def guesses_for(trivium)
    guesses.where trivium_id: trivium.id
  end
end
