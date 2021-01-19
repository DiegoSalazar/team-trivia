class TeamMessage < ApplicationRecord
  belongs_to :player
  belongs_to :team
  belongs_to :trivium
  belongs_to :guess, optional: true, dependent: :destroy

  scope :except_for, ->(messages) { where.not messages: { id: messages } }

  def sender_name
    player.username
  end
end
