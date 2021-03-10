# frozen_string_literal: true

class VotesReflex < ApplicationReflex
  def create
    @current_trivium = Trivium.find element.dataset.trivium_id
    @current_guess = Guess.find element.dataset.guess_id
    @current_question = @current_guess.question
    @current_team = current_player.current_team
    @title = @current_team.chat_title
    @team_messages = @current_team.team_messages
    @message = @current_guess.team_message

    @current_guess.vote_by voter: current_player

    # Upvoted question status
    question_status = QuestionStatusComponent.new \
      @current_question,
      num: question.num_accepted_guesses,
      denom: question.guesses.count,
      title: 'Accepted / Guesses'
    question_status_html = controller.render question_status

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

      # Update question status
      cable_ready[player.chat_channel].outer_html \
        selector: "##{question_status.id}",
        html: question_status_html
    end

    # Update current_player's message
    message_html = controller.render TeamMessageComponent.new \
      message: @message,
      player: current_player,
      trivium: @current_trivium
    cable_ready[current_player.chat_channel].outer_html \
      selector: dom_id(@message),
      html: message_html

    # Update current_player's question status
    cable_ready[current_player.chat_channel].outer_html \
      selector: "##{question_status.id}",
      html: question_status_html

    cable_ready.broadcast
    morph :nothing
  end
end
