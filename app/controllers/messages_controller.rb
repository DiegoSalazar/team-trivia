class MessagesController < ApplicationController
  include CableReady::Broadcaster

  before_action :authenticate_player!
  before_action :set_trivium
  before_action :set_team

  def create
    message = current_player.messages.new message_params
    message.team = @team
    message.trivium = @trivium
    message.save!
    message_html = render_to_string partial: 'message', locals: { message: message }

    @team.players.each do |player|
      next if player.id == current_player.id

      cable_ready[player.chat_channel].insert_adjacent_html(
        selector: '#messages',
        position: 'beforeend',
        html: message_html
      )
    end
    cable_ready.broadcast
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
