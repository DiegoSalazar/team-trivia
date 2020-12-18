class MessagesController < ApplicationController
  include CableReady::Broadcaster

  before_action :authenticate_player!
  before_action :set_trivium
  before_action :set_team

  def create
    message = current_player.messages.new message_params
    message.team = current_player.current_team || Team.find(1)
    message.trivium = Trivium.active
    message.save!

    cable_ready[current_player.chat_room].insert_adjacent_html(
      selector: '#messages',
      position: 'afterend',
      html: render_to_string(partial: 'message', locals: { message: message })
    )
    cable_ready.broadcast

    redirect_to play_team_path(message.team)
  end

  private

  def set_trivium
    @trivium = Trivium.active
  end

  def set_team
    @team = current_player.current_team
  end

  def message_params
    params.require(:message).permit :body
  end
end
