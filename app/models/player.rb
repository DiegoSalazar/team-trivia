# frozen_string_literal: true

class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  acts_as_voter

  belongs_to :team, optional: true
  has_many :trivia
  has_many :team_messages
  has_many :guesses
  has_many :questions

  def chat_channel
    "#{current_team.chat_room}-player-#{id}"
  end

  def current_team
    team || create_self_team!
  end

  def team_name
    current_team&.name
  end

  def joined_team?(team)
    team_id == team.id
  end

  def in_self_team?
    team&.name == username
  end

  def in_team?(team)
    team_id == team.id
  end

  def moderates?(trivium)
    trivium_ids.include? trivium.id
  end

  private

  def create_self_team!
    create_team! name: username
  end
end
