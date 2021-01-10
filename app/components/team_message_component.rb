# frozen_string_literal: true

class TeamMessageComponent < ViewComponent::Base
  attr_reader :body,  :created_at

  def initialize(team_message:, current_player:, sender_name: 'You (or sender')
    @team_message = team_message
    @current_player = current_player
    @sender_name = sender_name
    @body = team_message.body
    @created_at = team_message.created_at
  end

  def description
    return 'You' if sender?
    
    @team_message.sender_name
  end

  private

  def sender?
    @current_player.id == @team_message.player_id
  end

  def container_class
    'text-right' if sender?
  end
  
  def body_class
    return 'alert-secondary' if sender?
    'alert-primary'
  end
end
