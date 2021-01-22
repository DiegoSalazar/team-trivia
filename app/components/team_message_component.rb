# frozen_string_literal: true

class TeamMessageComponent < ViewComponent::Base
  attr_reader :message, :created_at

  def initialize(message:, player:, trivium:)
    super
    @message = message
    @player = player
    @trivium = trivium
    @guess = message.guess
    @created_at = message.created_at
  end

  def sender
    sender? ? 'You' : @message.sender_name
  end

  def body
    @guess.present? ? guess_body : @message.body
  end

  def container_class
    'text-right' if sender?
  end

  def body_class
    alert_class = sender? ? 'secondary' : 'primary'
    alert_class = 'success' if their_guess_accepted?
    alert_class = 'dark border shadow' if my_guess_accepted?
    "alert-#{alert_class}"
  end

  def votable
    return if sender? || @guess.blank?

    controller.render VoteComponent.new @player, @guess
  end

  def acceptable
    return unless my_guess_accepted?

    controller.render CheckmarkComponent.new
  end

  private

  def sender?
    @player.id == @message.player_id
  end

  def their_guess_accepted?
    @guess&.accepted? && !sender?
  end

  def my_guess_accepted?
    @guess&.accepted? && sender?
  end

  def guess_body
    q_num = @guess.question_number @trivium
    "Guess for question #{q_num}: #{@guess.value}"
  end
end
