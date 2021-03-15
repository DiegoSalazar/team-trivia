# frozen_string_literal: true

class ChatComponent < ViewComponent::Base
  def initialize(title, messages, player, trivium)
    super
    @title = title
    @messages = messages
    @player = player
    @trivium = trivium
    @show_message_form = !player.in_self_team?
    @title = 'My Guesses' if player.in_self_team?
  end
end
