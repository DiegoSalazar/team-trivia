class TriviumRevealChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'trivium_reveal'
  end

  def unsubscribed
    stop_all_streams
  end
end
