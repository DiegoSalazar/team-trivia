class TeamMessagesController < ApplicationController
  include CableReady::Broadcaster

  before_action :authenticate_player!

  def create
    message = current_player.team_messages.new team: current_team, trivium: current_trivium
    message.update! message_params
    message_html = render_to_string partial: 'recipient_message', locals: { team_message: message }

    current_team.players.each do |player|
      next if player.id == current_player.id

      cable_ready[player.chat_channel].insert_adjacent_html(
        selecto[r: '#team_messages',
        position: 'beforeend',
        html: message_html
      )
    end

    cable_ready[current_player.chat_channel].insert_adjacent_html(
      selector: '#team_messages',
      position: 'beforeend',
      html: render_to_string(partial: 'sender_message', locals: { team_message: message })
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
