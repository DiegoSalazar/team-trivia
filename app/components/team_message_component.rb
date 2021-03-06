# frozen_string_literal: true

class TeamMessageComponent < ViewComponent::Base
  include PlayerGuesses

  attr_reader :message, :body, :created_at

  def initialize(message:, player:, trivium:)
    super
    @message = message
    @player = player
    @trivium = trivium
    @guess = message.guess
    @body = message.body
    @created_at = message.created_at
  end

  def sender
    sender? ? 'You' : @message.sender_name
  end

  def sent_ago
    " - #{time_ago_in_words created_at} ago"
  end

  def container_class
    'text-right' if sender?
  end

  def body_class
    klass = sender? ? 'secondary' : 'primary'
    klass = 'warning' if @guess.present?
    klass = 'success border shadow' if their_guess_accepted?
    klass = 'dark border shadow' if my_guess_accepted?

    "alert-#{klass}"
  end

  def guessable
    return if @guess.blank?

    controller.render GuessedByComponent.new @message, @player, @trivium
  end

  def votable
    return if sender? || @guess.blank?

    controller.render VoteComponent.new @player, @guess
  end

  def acceptable
    return unless my_guess_accepted?

    controller.render CheckmarkComponent.new
  end
end
