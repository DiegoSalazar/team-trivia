class Message < ApplicationRecord
  belongs_to :player
  belongs_to :team
  belongs_to :trivium

  def sender_name
    player.username
  end
end
