# frozen_string_literal: true

class VotesReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #   - params - parameters from the element's closest form (if any)
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

  def create
    @current_trivium = Trivium.active
    @current_guess = Guess.find element.dataset.guess_id
    @current_question = @current_guess.question_template
    @current_team = current_player.current_team
    @title = @current_team.chat_title
    @team_messages = @current_team.team_messages
    @message = @current_guess.team_message

    @current_guess.vote_by voter: current_player

    # Updated question list
    question_list = controller.render QuestionListComponent.new \
      @current_trivium.question_templates,
      @current_question,
      @current_trivium

    # Broadcast to team
    @current_team.players.each do |player|
      next if player.id == current_player.id

      # Update their chat
      message = controller.render TeamMessageComponent.new \
        message: @message,
        player: player,
        trivium: @current_trivium
      cable_ready[player.chat_channel].outer_html \
        selector: dom_id(@message),
        html: message

      # Update their question list
      cable_ready[player.chat_channel].outer_html \
        selector: '#question-list',
        html: question_list
    end

    # Update current_player's message
    message_html = controller.render TeamMessageComponent.new \
      message: @message,
      player: current_player,
      trivium: @current_trivium
    cable_ready[current_player.chat_channel].outer_html \
      selector: dom_id(@message),
      html: message_html
    # Update current_player's question_list
    cable_ready[current_player.chat_channel].outer_html \
      selector: '#question-list',
      html: question_list

    cable_ready.broadcast
    morph :nothing
  end
end
