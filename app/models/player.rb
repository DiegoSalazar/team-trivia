# frozen_string_literal: true

class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :joins
  has_many :teams, through: :joins
  has_many :messages

  delegate :chat_room, to: :current_team

  def username
    email.split(?@).first
  end

  # TODO: remove Team.first when team join logic is done
  def current_team
    teams.first || Team.first
  end
end
