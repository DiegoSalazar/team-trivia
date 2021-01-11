# frozen_string_literal: true

class TeamMessageComponent < ViewComponent::Base
  attr_reader :body,  :created_at

  def initialize(message:, player:, sender_name: 'You (or sender')
    @message = message
    @player = player
    @guess = message.guess
    @sender_name = sender_name
    @created_at = message.created_at
  end

  def sender
    sender? ? 'You' : @message.sender_name
  end

  def body
    return guess_body if @guess.present?

    @message.body
  end

  private

  def sender?
    @player.id == @message.player_id
  end

  def guess_body
    "Guess for question #{@guess.question_template_id}: #{@guess.value}"
  end

  def container_class
    'text-right' if sender?
  end
  
  def body_class
    alert_class = sender? ? 'secondary' : 'primary'
    "alert-#{alert_class}"
  end
end
