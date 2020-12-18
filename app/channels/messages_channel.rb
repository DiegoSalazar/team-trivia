class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from current_player.chat_channel
  end

  def unsubscribed
    stop_all_streams
  end
end
