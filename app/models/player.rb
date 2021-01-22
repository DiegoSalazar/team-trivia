# frozen_string_literal: true

class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  acts_as_voter

  has_many :joins
  has_many :teams, through: :joins
  has_many :team_messages

  def username
    email.split(?@).first
  end

  def chat_channel
    "#{current_team.chat_room}-player-#{id}"
  end

  def current_team
    teams.first
  end

  def team_name
    current_team&.name || username
  end

  def joined_team?(team)
    team_ids.include? team.id
  end
end
