class MessagesController < ApplicationController
  before_action :authenticate_player!
  before_action :set_trivium
  before_action :set_team

  def create
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
