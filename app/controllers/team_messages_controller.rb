class TeamMessagesController < ApplicationController
  include Pagy::Backend
  include CableReady::Broadcaster

  before_action :authenticate_player!
  before_action :set_current_trivium, only: :create

  def index
    @pagy, @team_messages = pagy TeamMessage.recent
  end

  def create
    message = current_player.team_messages.new team: current_team, trivium: current_trivium
    message.update! message_params

    # Broadcast message to all team players
    current_team.players.each do |player|
      cable_ready[player.chat_channel].insert_adjacent_html \
        selector: '#team_messages',
        position: 'beforeend',
        html: render_to_string(TeamMessageComponent.new(
          message: message,
          player: player,
          trivium: current_trivium
        ))

      # Trigger explicit team message event so we can scroll the chat
      cable_ready[player.chat_channel].dispatch_event(
        name: 'team-message',
        selector: '#team_messages'
      )
    end

    # Refresh current_player's message form
    cable_ready[current_player.chat_channel].inner_html \
      selector: '#new_team_message',
      focus_selector: '#team_message_body',
      html: render_to_string(partial: 'team_messages/form')

    cable_ready.broadcast
  end

  private

  def message_params
    params.require(:team_message).permit :body
  end
end
