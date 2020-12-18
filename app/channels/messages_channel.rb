class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from team_channel
  end

  def unsubscribed
    stop_all_streams
  end

  private

  # TODO: remove mock team id
  def team_channel
    "team-#{current_player.current_team&.id || 1}-messages"
  end
end
