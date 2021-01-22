class TeamMessagesController < ApplicationController
  include CableReady::Broadcaster

  before_action :authenticate_player!

  def create
    message = current_player.team_messages.new team: current_team, trivium: current_trivium
    message.update! message_params

    # Broadcast message to team
    current_team.players.each do |player|
      next if player.id == current_player.id

      cable_ready[player.chat_channel].insert_adjacent_html(
        selector: '#team_messages',
        position: 'beforeend',
        html: render_to_string(TeamMessageComponent.new(
          message: message,
          player: player,
          trivium: current_trivium
        ))
      )
    end

    # Update current_player's message and form
    cable_ready[current_player.chat_channel].insert_adjacent_html(
      selector: '#team_messages',
      position: 'beforeend',
      html: render_to_string(TeamMessageComponent.new(
        message: message,
        player: current_player,
        trivium: current_trivium
      ))
    )
    cable_ready[current_player.chat_channel].inner_html(
      selector: '#new_team_message',
      focus_selector: '#team_message_body',
      html: render_to_string(partial: 'team_messages/form')
    )
    cable_ready.broadcast
  end

  private

  def message_params
    params.require(:team_message).permit :body
  end
end
